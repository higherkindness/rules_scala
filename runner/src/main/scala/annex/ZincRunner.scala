package annex

import sbt.internal.inc.Analysis
import sbt.internal.inc.AnalyzingCompiler
import sbt.internal.inc.CompileFailed
import sbt.internal.inc.FreshCompilerCache
import sbt.internal.inc.IncrementalCompilerImpl
import sbt.internal.inc.Locate
import sbt.internal.inc.LoggedReporter
import sbt.internal.inc.ZincUtil
import sbt.testing.Fingerprint
import sbt.testing.Framework
import sbt.testing.AnnotatedFingerprint
import sbt.testing.SubclassFingerprint

import xsbt.api.Discovery

import xsbti.Logger
import xsbti.T2
import xsbti.Reporter
import xsbti.api.AnalyzedClass
import xsbti.api.ClassLike
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

import com.google.devtools.build.buildjar.jarhelper.JarCreator

import java.io.File
import java.io.PrintWriter
import java.lang.management.ManagementFactory
import java.nio.file.Files
import java.net.URLClassLoader;
import java.util.Optional
import java.util.function.Supplier;

object ZincRunner {
  def main(args: Array[String]): Unit = {

    val toAbsoluteFile: File => File = f => new File(f.getAbsolutePath)

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
    val frameworkClassNames = args.drop(8 + n1 + n2 + n3).take(n4).toList
    val n5 = args(8 + n1 + n2 + n3 + n4).toInt
    val allowedDeps = args.drop(9 + n1 + n2 + n3 + n4).take(n5)
      .map(new File(_)).toSet.map(toAbsoluteFile)
    val n6 = args(9 + n1 + n2 + n3 + n4 + n5).toInt
    val ignoredDeps = args.drop(10 + n1 + n2 + n3 + n4 + n5).take(n6)
      .map(new File(_)).toSet.map(toAbsoluteFile)

    // end yolo

    Files.createDirectories(classesDirectory.toPath)

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
          println(s"Oh no: $e")
          System.exit(-1)
          null
      }

    val analysis: Analysis =
      compileResult
        .analysis.asInstanceOf[Analysis]

    val relations = analysis.relations
    val classpathDeps = classpath.toSet.map(toAbsoluteFile)

    val bootDeps =
      ManagementFactory.getRuntimeMXBean
        .getBootClassPath.split(":")
        .map(new File(_)).toSet

    val usedDeps = relations.allLibraryDeps -- bootDeps
    //println("used: " + usedDeps)
    //println("allowed: " + allowedDeps)
    //println("ignored: " + ignoredDeps)

    // dependencies we shouldn't be allowed to reference directly
    val verbotenDeps = usedDeps -- allowedDeps -- ignoredDeps
    if (!verbotenDeps.isEmpty) {
      verbotenDeps.foreach(dep =>
        println(s"forbidden dep: $dep"))
      System.exit(-1)
    }

    // dependencies we said we'd use... but didn't
    val unusedDeps =
      allowedDeps -- usedDeps - toAbsoluteFile(scalaInstance.libraryJar)
    if (!unusedDeps.isEmpty) {
      unusedDeps.foreach(dep =>
        println(s"unused dep: $dep"))
      System.exit(-1)
    }

    val mains =
      analysis
        .infos.allInfos.values.toList
        .flatMap(_.getMainClasses.toList)
        .sorted

    val pw = new PrintWriter(new File(output + ".mains.txt"))
    mains.foreach(pw.println)
    pw.close

    if (!frameworkClassNames.isEmpty) {
      val loader = new URLClassLoader(
        classpath.map(_.toURI.toURL),
        classOf[Framework].getClassLoader)

      val frameworks = frameworkClassNames.flatMap(getFramework(loader, _))
      val definitions = potentialTests(analysis)
      val (subclassPrints, annotatedPrints) = getFingerprints(frameworks)
      val discovered = Discovery(subclassPrints.map(_._1), annotatedPrints.map(_._1))(definitions)
      discovered.foreach {
        case (defn, discovered) =>
          //println(">> " + defn)
      }
    }

    val jarCreator = new JarCreator(output)
    jarCreator.addDirectory(classesDirectory)
    jarCreator.setCompression(true)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)

    mains match {
      case main :: Nil =>
        jarCreator.setMainClass(main)
      case _ =>
    }

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
          case other =>
            println(s"Framework not supported: $className")
            None
        }
    } catch {
      case _: ClassNotFoundException => None
      case ex: Throwable =>
        println(s"Couldn't initialize framework: $className")
        ex.printStackTrace()
        None
    }

  private def potentialTests(analysis: CompileAnalysis): Seq[ClassLike] = {
    val all = allDefs(analysis)
    all.collect {
      case cl: ClassLike if cl.topLevel => cl
    }
  }

  private def allDefs(analysis: CompileAnalysis) = analysis match {
    case analysis: Analysis =>
      val acs: Seq[AnalyzedClass] = analysis.apis.internal.values.toVector
      acs.flatMap { ac =>
        val companions = ac.api
        val all =
          Seq(companions.classApi, companions.objectApi) ++
        companions.classApi.structure.declared ++ companions.classApi.structure.inherited ++
        companions.objectApi.structure.declared ++ companions.objectApi.structure.inherited

        all
      }
  }

  // todo: a bunch of this is ripped from:
  // - sbt
  // - bloop

  private type PrintInfo[F <: Fingerprint] = (String, Boolean, Framework, F)

  def getFingerprints(
    frameworks: List[Framework]
  ): (Set[PrintInfo[SubclassFingerprint]], Set[PrintInfo[AnnotatedFingerprint]]) = {
    import scala.collection.mutable
    val subclasses = mutable.Set.empty[PrintInfo[SubclassFingerprint]]
    val annotated = mutable.Set.empty[PrintInfo[AnnotatedFingerprint]]
    for {
      framework <- frameworks
      fingerprint <- framework.fingerprints()
    } fingerprint match {
      case sub: SubclassFingerprint =>
        subclasses += ((sub.superclassName, sub.isModule, framework, sub))
      case ann: AnnotatedFingerprint =>
        annotated += ((ann.annotationName, ann.isModule, framework, ann))
    }
    (subclasses.toSet, annotated.toSet)
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
