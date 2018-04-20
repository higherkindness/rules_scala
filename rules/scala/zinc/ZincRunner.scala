package annex

import annex.worker.WorkerMain

import sbt.internal.inc.Analysis
import sbt.internal.inc.AnalyzingCompiler
import sbt.internal.inc.CompileFailed
import sbt.internal.inc.FreshCompilerCache
import sbt.internal.inc.IncrementalCompilerImpl
import sbt.internal.inc.Locate
import sbt.internal.inc.LoggedReporter
import sbt.internal.inc.ZincUtil

import scala.collection.JavaConverters._
import scala.util.control.NonFatal

import xsbti.Logger
import xsbti.Reporter
import xsbti.compile.AnalysisContents
import xsbti.compile.ClasspathOptionsUtil
import xsbti.compile.Compilers
import xsbti.compile.CompileAnalysis
import xsbti.compile.CompileOptions
import xsbti.compile.CompileResult
import xsbti.compile.DefinesClass
import xsbti.compile.FileAnalysisStore
import xsbti.compile.IncOptions
import xsbti.compile.Inputs
import xsbti.compile.MiniSetup
import xsbti.compile.PerClasspathEntryLookup
import xsbti.compile.PreviousResult
import xsbti.compile.ScalaInstance
import xsbti.compile.Setup

import com.google.devtools.build.buildjar.jarhelper.JarCreator

import java.io.File
import java.io.PrintWriter
import java.lang.management.ManagementFactory
import java.nio.file.Files
import java.nio.file.Paths
import java.net.URLClassLoader
import java.util.Optional
import java.util.Properties
import java.util.function.Supplier

object ZincRunner extends WorkerMain[Env] {

  val toFile: String => File = s => new File(s)
  val toAbsolute: File => File = f => new File(f.getAbsolutePath)
  val toAbsoluteFile: String => File = toFile andThen toAbsolute

  protected[this] def init(args: Option[Array[String]]) = Env.read(args.map(_.toSeq))

  protected[this] def work(env: Env, args: Array[String]) = {
    val finalArgs = args.flatMap {
      case arg if arg.startsWith("@") => Files.readAllLines(Paths.get(arg.tail)).asScala
      case arg                        => Seq(arg)
    }
    val options = Options.read(finalArgs.toList, env)

    Files.createDirectories(Paths.get(options.outputDir))

    val persistence = options.persistenceDir.fold[Persistence](NullPersistence) { dir =>
      val rootDir = Paths.get(dir.replace("~", sys.props.getOrElse("user.home", "")))
      val path = options.label.replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_")
      new FilePersistence(rootDir.resolve(path), Paths.get(options.outputDir))
    }

    val scalaInstance = AnxScalaInstance(options.scalaVersion, options.compilerClasspath.map(toFile).toArray)

    val compilerBridgeJar = new File(options.compilerBridge)

    val logger = new AnxLogger

    val scalaCompiler: AnalyzingCompiler =
      ZincUtil.scalaCompiler(scalaInstance, compilerBridgeJar)

    val compilers: Compilers = ZincUtil.compilers(scalaInstance, ClasspathOptionsUtil.boot, None, scalaCompiler)

    val compileOptions: CompileOptions =
      CompileOptions.create
        .withSources(options.sources.map(toAbsoluteFile).toArray)
        .withClasspath(
          Array.concat(
            Array(toFile(options.outputDir)),
            options.compilationClasspath.map(toFile).toArray,
            options.compilerClasspath.map(toFile).toArray
          )
        ) // err??
        .withClassesDirectory(new File(options.outputDir))
        .withScalacOptions(options.pluginsClasspath.map(p => s"-Xplugin:${p}").toArray)

    val loadedContents = try persistence.load()
    catch {
      case NonFatal(e) =>
        logger.warn(() => "Failed to load analysis: $e")
        None
    }
    val previousResult = persistence.load().fold(PreviousResult.of(Optional.empty(), Optional.empty())) { contents =>
      PreviousResult.of(Optional.of(contents.getAnalysis), Optional.of(contents.getMiniSetup))
    }

    val skip = false
    val lookup: PerClasspathEntryLookup = new AnxPerClasspathEntryLookup
    val reporter: Reporter = new LoggedReporter(10, logger)
    val compilerCache = new FreshCompilerCache
    val incOptions = IncOptions.create()

    val setup: Setup =
      Setup.create(lookup, skip, null, compilerCache, incOptions, reporter, Optional.empty(), Array.empty)

    val inputs: Inputs = Inputs.of(compilers, compileOptions, setup, previousResult)

    val compiler: IncrementalCompilerImpl = new IncrementalCompilerImpl()
    val compileResult: CompileResult =
      try {
        compiler.compile(inputs, logger)
      } catch {
        case e: CompileFailed =>
          println(s"Oh no: $e")
          //e.printStackTrace()
          sys.exit(-1)
      }

    val analysisContents = AnalysisContents.create(compileResult.analysis, compileResult.setup)

    try persistence.save(analysisContents)
    catch {
      case NonFatal(e) => logger.warn(() => "Failed to save analysis: $e")
    }

    FileAnalysisStore.getDefault(new File(options.analysisPath)).set(analysisContents)

    val analysis = compileResult.analysis.asInstanceOf[Analysis]

    val compilationDeps = options.compilationClasspath.toSet.map(toAbsoluteFile)
    val allowedDeps = options.allowedClasspath.toSet.map(toAbsoluteFile)

    val bootDeps = ManagementFactory.getRuntimeMXBean.getBootClassPath.split(sys.props("path.separator")).map(toFile)

    val usedDeps = analysis.relations.allLibraryDeps -- bootDeps
    //println("used: " + usedDeps)
    //println("allowed: " + allowedDeps)
    //println("ignored: " + ignoredDeps)

    // dependencies that we directly reference but didn't explicitly list
    // as a compile time dep (and were potentially needed on the compilation
    // classpath, transitively, to keep scalac happy)
    val illicitlyUsedDeps = usedDeps -- allowedDeps -- scalaInstance.allJars.map(toAbsolute)

    if (illicitlyUsedDeps.nonEmpty) {
      illicitlyUsedDeps.foreach(dep => logger.error(() => s"illicitly used dep: $dep"))
      sys.exit(-1)
    }

    // dependencies we said we'd use... but didn't
    val unusedDeps = allowedDeps -- usedDeps
    if (unusedDeps.nonEmpty) {
      unusedDeps.foreach(dep => logger.error(() => s"unused dep: $dep"))
      sys.exit(-1)
    }

    val mains =
      analysis.infos.allInfos.values.toList
        .flatMap(_.getMainClasses.toList)
        .sorted

    // TODO: pass in a param for this...
    val pw = new PrintWriter(new File(options.outputJar + ".mains.txt"))
    mains.foreach(pw.println)
    pw.close

    val jarCreator = new JarCreator(options.outputJar)
    jarCreator.addDirectory(options.outputDir)
    jarCreator.setCompression(true)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)

    mains match {
      case main :: Nil =>
        jarCreator.setMainClass(main)
      case _ =>
    }

    jarCreator.execute()

    env
  }
}

final class AnxPerClasspathEntryLookup extends PerClasspathEntryLookup {
  override def analysis(classpathEntry: File): Optional[CompileAnalysis] =
    Optional.empty[CompileAnalysis]
  override def definesClass(classpathEntry: File): DefinesClass =
    Locate.definesClass(classpathEntry)
}

final case class AnxScalaInstance(
  version: String,
  allJars: Array[File]
) extends ScalaInstance {

  lazy val loader: ClassLoader =
    new URLClassLoader(allJars.map(_.toURI.toURL), null)

  lazy val loaderLibraryOnly: ClassLoader =
    new URLClassLoader(Array(libraryJar.toURI.toURL), null)

  lazy val actualVersion: String = {
    val stream = loader.getResourceAsStream("compiler.properties")
    try {
      val props = new Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  lazy val libraryJar: File =
    allJars
      .find(f => f.getName.endsWith(".jar") && f.getName.startsWith("scala-library"))
      .orNull

  lazy val compilerJar: File =
    allJars
      .find(f => f.getName.endsWith(".jar") && f.getName.startsWith("scala-compiler"))
      .orNull

  lazy val otherJars: Array[File] =
    allJars
      .filterNot(f => f == libraryJar || f == compilerJar)
}

final class AnxLogger extends Logger {

  def error(msg: Supplier[String]): Unit =
    println(s"[error]: ${msg.get}")

  def warn(msg: Supplier[String]): Unit =
    println(s"[warn ]: ${msg.get}")

  def info(msg: Supplier[String]): Unit =
    println(s"[info ]: ${msg.get}")

  def debug(msg: Supplier[String]): Unit =
    println(s"[debug]: ${msg.get}")

  def trace(err: Supplier[Throwable]): Unit =
    println(s"[trace]: ${err.get.getMessage}")

}
