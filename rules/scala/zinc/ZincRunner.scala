package annex.zinc

import annex.compiler.Arguments
import annex.compiler.Arguments.LogLevel
import annex.worker.WorkerMain
import com.google.devtools.build.buildjar.jarhelper.JarCreator
import java.io.{File, PrintWriter}
import java.net.URLClassLoader
import java.nio.file._
import java.util.function.Supplier
import java.util.zip.ZipInputStream
import java.util.{Optional, Properties}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.inf.Namespace
import sbt.internal.inc.{Hash => _, ScalaInstance => _, _}
import sbt.io.Hash
import scala.annotation.tailrec
import scala.collection.JavaConverters._
import scala.util.Try
import scala.util.control.NonFatal
import xsbti.compile.{FileAnalysisStore => _, _}
import xsbti.{Logger, Reporter}

object ZincRunner extends WorkerMain[Namespace] {

  private[this] val compilerCache = CompilerCache.createCacheFor(10)

  protected[this] def init(args: Option[Array[String]]) = {
    val parser = ArgumentParsers.newFor("zinc-worker").addHelp(true).build
    parser.addArgument("--persistence_dir", /* deprecated */ "--persistenceDir").metavar("path")
    parser.parseArgsOrFail(args.getOrElse(Array.empty))
  }

  protected[this] def work(worker: Namespace, args: Array[String]) = {
    val parser = ArgumentParsers.newFor("zinc").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build()
    Arguments.add(parser)
    val namespace = parser.parseArgsOrFail(args)

    val debug = namespace.getBoolean("debug")
    val format = if (debug) AnxAnalysisStore.TextFormat else AnxAnalysisStore.BinaryFormat

    val tmpDir = namespace.get[File]("tmp").toPath
    try FileUtil.delete(tmpDir)
    catch { case _: NoSuchFileException => }

    val classesDir = tmpDir.resolve("classes")

    val path = namespace.getString("label").replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_")
    val classesOutputDir = classesDir.resolve(path)
    Files.createDirectories(classesOutputDir)

    // https://github.com/sbt/zinc/pull/532
    val analysisFiles = AnalysisFiles(
      namespace.get[File]("output_analysis").toPath,
      namespace.get[File]("output_apis").toPath,
    )
    val analysisStore = new AnxAnalysisStore(analysisFiles, format)

    val persistence = Option(worker.getString("persistence_dir")).fold[ZincPersistence](NullPersistence) { dir =>
      val rootDir = Paths.get(dir.replace("~", sys.props.getOrElse("user.home", "")))
      new FilePersistence(rootDir.resolve(path), analysisFiles, classesOutputDir)
    }

    val scalaInstance = new AnxScalaInstance(namespace.getList[File]("compiler_classpath").asScala.toArray)

    val logger = new AnxLogger(namespace.getString("log_level"))

    val scalaCompiler = ZincUtil.scalaCompiler(scalaInstance, namespace.get[File]("compiler_bridge"))

    val compilers = ZincUtil.compilers(scalaInstance, ClasspathOptionsUtil.boot, None, scalaCompiler)

    val sources = namespace.getList[File]("sources").asScala ++
      namespace.getList[File]("source_jars").asScala.zipWithIndex.flatMap {
        case (jar, i) =>
          val fileStream = Files.newInputStream(jar.toPath)
          try {
            val zipStream = new ZipInputStream(fileStream)
            @tailrec
            def next(files: List[File]): List[File] = {
              zipStream.getNextEntry match {
                case null => files
                case entry if entry.isDirectory =>
                  zipStream.closeEntry()
                  next(files)
                case entry =>
                  val file = tmpDir.resolve("src").resolve(i.toString).resolve(entry.getName)
                  Files.createDirectories(file.getParent)
                  Files.copy(zipStream, file, StandardCopyOption.REPLACE_EXISTING)
                  zipStream.closeEntry()
                  next(file.toFile :: files)
              }
            }
            next(Nil)
          } finally {
            fileStream.close()
          }
      }

    val analyses = namespace
      .getList[String]("analyses")
      .asScala
      .flatMap { value =>
        val Array(id, analyses, jars) = value.split("=", 3)
        val Array(analysis, apis) = analyses.split(",", 2)
        jars.split(",").map(jar => Paths.get(jar) -> (id, AnalysisFiles(Paths.get(analysis), Paths.get(apis))))
      }
      .toMap

    val originalClasspath: Seq[Path] = namespace.getList[File]("classpath").asScala.map(_.toPath)

    val deps = Dep.create(originalClasspath, classesDir, analyses /* Map.empty */ )

    val compileOptions =
      CompileOptions.create
        .withSources(sources.map(_.getAbsoluteFile).toArray)
        .withClasspath((classesOutputDir +: deps.map(_.classpath)).map(_.toFile).toArray)
        .withClassesDirectory(classesOutputDir.toFile)
        .withJavacOptions(namespace.getList[String]("java_compiler_option").asScala.toArray)
        .withScalacOptions(
          Array.concat(
            namespace.getList[File]("plugins").asScala.map(p => s"-Xplugin:$p").toArray,
            Option(namespace.getList[String]("compiler_option")).fold[Seq[String]](Nil)(_.asScala).toArray,
          )
        )

    try persistence.load()
    catch {
      case NonFatal(e) =>
        logger.warn(() => s"Failed to load cached analysis: $e".toString)
        None
    }
    val previousResult = Try(analysisStore.get())
      .fold({ e =>
        logger.warn(() => s"Failed to load previous analysis: $e")
        Optional.empty[AnalysisContents]()
      }, identity)
      .map[PreviousResult](
        contents => PreviousResult.of(Optional.of(contents.getAnalysis), Optional.of(contents.getMiniSetup))
      )
      .orElseGet(() => PreviousResult.of(Optional.empty(), Optional.empty()))

    val skip = false
    val lookup = new AnxPerClasspathEntryLookup(
      deps
        .collect {
          case ExternalDep(_, classpath, analyses) => classpath.toFile -> new AnxAnalysisStore(analyses, format)
        }
        .toMap
        .get
    )
    val reporter: Reporter = new LoggedReporter(10, logger)
    val incOptions = IncOptions.create()

    val setup: Setup =
      Setup.create(lookup, skip, null, compilerCache, incOptions, reporter, Optional.empty(), Array.empty)

    val inputs: Inputs = Inputs.of(compilers, compileOptions, setup, previousResult)

    val compiler: IncrementalCompilerImpl = new IncrementalCompilerImpl()
    val compileResult: CompileResult =
      try compiler.compile(inputs, logger)
      catch {
        case _: CompileFailed => sys.exit(-1)
        case e: ClassFormatError =>
          System.err.println(e)
          println("You may be missing a `macro = True` attribute.")
          sys.exit(1)
      }

    analysisStore.set(AnalysisContents.create(compileResult.analysis, compileResult.setup))

    try persistence.save()
    catch {
      case NonFatal(e) => logger.warn(() => s"Failed to save cached analysis: $e")
    }

    val analysis = compileResult.analysis.asInstanceOf[Analysis]
    val usedDeps =
      deps.filter(Dep.used(deps, analysis.relations, lookup)).filter(_.file != scalaInstance.libraryJar.toPath)
    Files.write(namespace.get[File]("output_used").toPath, usedDeps.map(_.file.toString).sorted.asJava)

    val mains =
      analysis.infos.allInfos.values.toList
        .flatMap(_.getMainClasses.toList)
        .sorted

    val pw = new PrintWriter(namespace.get[File]("main_manifest"))
    try mains.foreach(pw.println)
    finally pw.close()

    val jarCreator = new JarCreator(namespace.get[File]("output_jar").toPath)
    jarCreator.addDirectory(classesOutputDir)
    jarCreator.setCompression(true)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)

    mains match {
      case main :: Nil =>
        jarCreator.setMainClass(main)
      case _ =>
    }

    jarCreator.execute()

    worker
  }
}

final class AnxPerClasspathEntryLookup(analyses: File => Option[AnalysisStore]) extends PerClasspathEntryLookup {
  override def analysis(classpathEntry: File): Optional[CompileAnalysis] =
    analyses(classpathEntry).fold(Optional.empty[CompileAnalysis])(store => Optional.of(store.get().get.getAnalysis))
  override def definesClass(classpathEntry: File): DefinesClass =
    Locate.definesClass(classpathEntry)
}

final class AnxScalaInstance(val allJars: Array[File]) extends ScalaInstance {
  lazy val actualVersion = {
    val stream = loader.getResourceAsStream("compiler.properties")
    try {
      val props = new Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  def compilerJar = null

  lazy val libraryJar = allJars
    .find(f => new URLClassLoader(Array(f.toURI.toURL)).findResource("library.properties") != null)
    .get

  lazy val loader = new URLClassLoader(allJars.map(_.toURI.toURL), null)

  def loaderLibraryOnly = null

  def otherJars = null

  def version = actualVersion
}

final class AnxLogger(level: String) extends Logger {

  def debug(msg: Supplier[String]) = level match {
    case LogLevel.Debug => System.err.println(msg.get)
    case _              => Hash
  }

  def error(msg: Supplier[String]) = level match {
    case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn => println(msg.get)
    case _                                                               =>
  }

  def info(msg: Supplier[String]) = level match {
    case LogLevel.Debug | LogLevel.Info => System.err.println(msg.get)
    case _                              =>
  }

  def trace(err: Supplier[Throwable]) = level match {
    case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn => err.get.printStackTrace()
    case _                                                               =>
  }

  def warn(msg: Supplier[String]) = level match {
    case LogLevel.Debug | LogLevel.Info | LogLevel.Warn => System.err.println(msg.get)
    case _                                              =>
  }

}
