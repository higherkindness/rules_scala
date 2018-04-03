package annex

import sbt.internal.inc.Analysis
import sbt.internal.inc.AnalyzingCompiler
import sbt.internal.inc.CompileFailed
import sbt.internal.inc.FreshCompilerCache
import sbt.internal.inc.IncrementalCompilerImpl
import sbt.internal.inc.Locate
import sbt.internal.inc.LoggedReporter
import sbt.internal.inc.ZincUtil

import sbt.testing.Framework

import xsbti.compile.ClasspathOptionsUtil
import xsbti.compile.Compilers
import xsbti.compile.CompileAnalysis
import xsbti.compile.CompileOptions
import xsbti.compile.CompileProgress
import xsbti.compile.CompileResult
import xsbti.compile.DefinesClass
import xsbti.compile.IncOptions
import xsbti.compile.Inputs
import xsbti.compile.MiniSetup
import xsbti.compile.PerClasspathEntryLookup
import xsbti.compile.PreviousResult
import xsbti.compile.ScalaInstance
import xsbti.compile.Setup

import xsbti.Logger
import xsbti.T2
import xsbti.Reporter

import com.google.devtools.build.buildjar.jarhelper.JarCreator

import java.io.File
import java.net.URLClassLoader;
import java.util.Optional
import java.util.function.Supplier;

object ZincRunner {
  def main(args: Array[String]): Unit = {

    // begin yolo

    val output = args(0)
    val compilerBridge = args(1)
    val scalaVersion = args(2)
    val n1 = args(3).toInt
    val compilerClasspath = args.drop(4).take(n1).map(new File(_))
    val n2 = args(4 + n1).toInt
    val classpath = args.drop(5 + n1).take(n2).map(new File(_))
    val n3 = args(5 + n1 + n2).toInt
    val sources = args.drop(6 + n1 + n2).take(n3).map(new File(_))
    val classesDirectory = new File(args(6 + n1 + n2 + n3))
    val n4 = args(7 + n1 + n2 + n3).toInt
    val frameworks = args.drop(8 + n1 + n2 + n3).take(n4)

    // end yolo

    val toAbsoluteFile: File => File = f => new File(f.getAbsolutePath)

    val scalaInstance = AnxScalaInstance(
      scalaVersion,
      compilerClasspath)

    val compilerBridgeJar = new File(compilerBridge)

    val logger = new AnxLogger

    val scalaCompiler: AnalyzingCompiler =
      ZincUtil.scalaCompiler(scalaInstance, compilerBridgeJar)

    val compilers: Compilers = ZincUtil.compilers(
      scalaInstance,
      ClasspathOptionsUtil.boot,
      None,
      scalaCompiler)

    val compileOptions: CompileOptions =
      CompileOptions.create
        .withSources(sources.map(toAbsoluteFile))
        .withClasspath(
          Array.concat(classpath, compilerClasspath) // err??
        )
        .withClassesDirectory(
          classesDirectory)

    val previousResult: PreviousResult = PreviousResult.of(
      Optional.empty[CompileAnalysis], Optional.empty[MiniSetup])

    val skip = false
    val empty = Array.empty[T2[String, String]]
    val lookup: PerClasspathEntryLookup = new AnxPerClasspathEntryLookup
    val reporter: Reporter = new LoggedReporter(10, logger)
    val compilerCache = new FreshCompilerCache
    val cacheFile = new File(".anxcache")
    val incOptions = IncOptions.create()
    val progress = Optional.empty[CompileProgress]

    val setup: Setup = Setup.create(
      lookup, skip, cacheFile, compilerCache, incOptions, reporter, progress, empty)

    val inputs: Inputs = Inputs.of(
      compilers, compileOptions, setup, previousResult)

    val compiler: IncrementalCompilerImpl = new IncrementalCompilerImpl()
    val compileResult: CompileResult =
      try {
        compiler.compile(inputs, logger)
      } catch {
        case e: CompileFailed =>
          println("Oh no: $e")
          System.exit(-1)
          null
      }


    val mains =
      compileResult
        .analysis.asInstanceOf[Analysis]
        .infos.allInfos.values.toList
        .flatMap(_.getMainClasses.toList)
        .sorted

    println(s"discovered mains: $mains")

    val jarCreator = new JarCreator(output)
    jarCreator.addDirectory(classesDirectory)
    jarCreator.setCompression(true)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(true)
    jarCreator.execute()

    // end yolo for real
  }

  private def getFramework(
    loader: ClassLoader,
    className: String
  ): Option[Framework] =
    try {
      Class.forName(className, true, loader)
        .getDeclaredConstructor().newInstance() match {
          case framework: Framework =>
            Some(framework)
          case _ =>
            println(s"Framework not supported: $className")
            None
        }
    } catch {
      case _: ClassNotFoundException => None
      case ex: Throwable =>
        println(s"Couldn't initialize framework: $className")
        None
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
      val props = new java.util.Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  private[this] def unused: Nothing = sys.error("deprecated/unused")

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
