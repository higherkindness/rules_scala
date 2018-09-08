package annex.zinc

import annex.compiler.{AnxLogger, AnxScalaInstance, Arguments, FileUtil}
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
import sbt.internal.inc.classpath.ClassLoaderCache
import sbt.internal.inc.{Hash => _, ScalaInstance => _, _}
import sbt.io.Hash
import scala.annotation.tailrec
import scala.collection.JavaConverters._
import scala.util.Try
import scala.util.control.NonFatal
import xsbti.compile.{FileAnalysisStore => _, _}
import xsbti.{Logger, Reporter}

/**
 * <strong>Caching</strong>
 *
 * Zinc has two caches:
 *  1. a ClassLoaderCache which is a soft reference cache for classloaders of Scala compilers.
 *  2. a CompilerCache which is a hard reference cache for (I think) Scala compiler instances.
 *
 * The CompilerCache has reproducibility issues, so it needs to be a no-op.
 * The ClassLoaderCache needs to be reused else JIT reuse (i.e. the point of the worker strategy) doesn't happen.
 *
 * There are two sensible strategies for Bazel workers
 *  A. Each worker compiles multiple Scala versions. Trust the ClassLoaderCache's timestamp check. Maintain a hard
 *     reference to the classloader for the last version, and allow previous versions to be GC'ed subject to
 *     free memory and -XX:SoftRefLRUPolicyMSPerMB.
 *  B. Each worker compiles a single Scala version. Probably still use ClassLoaderCache + hard reference since
 *     ClassLoaderCache is hard to remove. The compiler classpath is passed via the initial flags to the worker
 *     (rather than the per-request arg file). Bazel worker management cycles out Scala compiler versions.
 * Currently, this runner follows strategy A.
 */
object ZincRunner extends WorkerMain[Namespace] {

  private[this] val classloaderCache = new ClassLoaderCache(null)

  private[this] val compilerCache = CompilerCache.fresh

  // prevents GC of the soft reference in classloaderCache
  private[this] var lastCompiler: AnyRef = null

  private[this] def labelToPath(label: String) = Paths.get(label.replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_"))

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
    val analysesFormat = new AnxAnalyses(format)

    val tmpDir = namespace.get[File]("tmp").toPath
    try FileUtil.delete(tmpDir)
    catch { case _: NoSuchFileException => }

    val classesDir = tmpDir.resolve("classes")
    val classesOutputDir = classesDir.resolve(labelToPath(namespace.getString("label")))
    Files.createDirectories(classesOutputDir)

    // https://github.com/sbt/zinc/pull/532
    val analysisFiles = AnalysisFiles(
      apis = namespace.get[File]("output_apis").toPath,
      miniSetup = namespace.get[File]("output_setup").toPath,
      relations = namespace.get[File]("output_relations").toPath,
      sourceInfos = namespace.get[File]("output_infos").toPath,
      stamps = namespace.get[File]("output_stamps").toPath,
    )
    val analysisStore = new AnxAnalysisStore(analysisFiles, analysesFormat)

    val persistence = Option(worker.getString("persistence_dir")).fold[ZincPersistence](NullPersistence) { dir =>
      val rootDir = Paths.get(dir.replace("~", sys.props.getOrElse("user.home", "")))
      val path = namespace.getString("label").replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_")
      new FilePersistence(rootDir.resolve(path), analysisFiles, classesOutputDir)
    }

    val scalaInstance = new AnxScalaInstance(namespace.getList[File]("compiler_classpath").asScala.toArray)

    val logger = new AnxLogger(namespace.getString("log_level"))

    val scalaCompiler = ZincUtil
      .scalaCompiler(scalaInstance, namespace.get[File]("compiler_bridge"))
      .withClassLoaderCache(classloaderCache)
    lastCompiler = scalaCompiler

    val compilers = ZincUtil.compilers(scalaInstance, ClasspathOptionsUtil.boot, None, scalaCompiler)

    val sources = namespace.getList[File]("sources").asScala ++
      namespace
        .getList[File]("source_jars")
        .asScala
        .zipWithIndex
        .flatMap {
          case (jar, i) => FileUtil.extractZip(jar.toPath, tmpDir.resolve("src").resolve(i.toString))
        }
        .map(_.toFile)

    val analyses = namespace
      .getList[String]("analyses")
      .asScala
      .flatMap { value =>
        val Array(label, analyses, jars) = value.tail.split("=", 3)
        val Array(apis, relations) = analyses.split(",", 2)
        jars
          .split(",")
          .map(
            jar =>
              Paths.get(jar) -> (classesDir
                .resolve(labelToPath(label)), DepAnalysisFiles(Paths.get(apis), Paths.get(relations)))
          )
      }
      .toMap

    val originalClasspath: Seq[Path] = namespace.getList[File]("classpath").asScala.map(_.toPath)

    val deps = Dep.create(originalClasspath, analyses)

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
    val depMap = deps.collect {
      case ExternalDep(_, classpath, files) => classpath -> files
    }.toMap
    val lookup = new AnxPerClasspathEntryLookup(file => {
      depMap
        .get(file)
        .map(
          files =>
            Analysis.Empty.copy(
              apis = analysesFormat.apis.read(files.apis),
              relations = analysesFormat.relations.read(files.relations)
          )
        )
    })
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

    FileUtil.delete(tmpDir)
    Files.createDirectory(tmpDir)

    worker
  }
}

final class AnxPerClasspathEntryLookup(analyses: Path => Option[CompileAnalysis]) extends PerClasspathEntryLookup {
  override def analysis(classpathEntry: File): Optional[CompileAnalysis] =
    analyses(classpathEntry.toPath).fold(Optional.empty[CompileAnalysis])(Optional.of(_))
  override def definesClass(classpathEntry: File): DefinesClass =
    Locate.definesClass(classpathEntry)
}
