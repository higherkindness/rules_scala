package higherkindness.rules_scala
package workers.zinc.compile

import workers.common.AnnexLogger
import workers.common.AnnexScalaInstance
import workers.common.CommonArguments
import workers.common.FileUtil
import workers.common.LoggedReporter
import common.worker.WorkerMain
import com.google.devtools.build.buildjar.jarhelper.JarCreator
import java.io.{File, PrintStream, PrintWriter}
import java.net.URLClassLoader
import java.nio.file.{Files, NoSuchFileException, Path, Paths}
import java.text.SimpleDateFormat
import java.util
import java.util.{Date, List => JList, Optional, Properties}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.{Arguments => Arg}
import net.sourceforge.argparse4j.inf.Namespace
import sbt.internal.inc.classpath.ClassLoaderCache
import sbt.internal.inc.caching.ClasspathCache
import sbt.internal.inc.{Analysis, CompileFailed, IncrementalCompilerImpl, Locate, PlainVirtualFile, PlainVirtualFileConverter, ZincUtil}
import scala.collection.JavaConverters._
import scala.util.Try
import scala.util.control.NonFatal
import xsbti.{Logger, T2, VirtualFile, VirtualFileRef}
import xsbti.compile.{AnalysisContents, Changes, ClasspathOptionsUtil, CompileAnalysis, CompileOptions, CompileProgress, CompilerCache, DefaultExternalHooks, DefinesClass, ExternalHooks, FileHash, IncOptions, Inputs, MiniSetup, PerClasspathEntryLookup, PreviousResult, Setup, TastyFiles}

// The list in this docstring gets clobbered by the formatter, unfortunately.
//format: off
/**
 * <strong>Caching</strong>
 *
 * Zinc has two caches:
 *   1. a ClassLoaderCache which is a soft reference cache for classloaders of Scala compilers.
 *   2. a CompilerCache which is a hard reference cache for (I think) Scala compiler instances.
 *
 * The CompilerCache has reproducibility issues, so it needs to be a no-op. The ClassLoaderCache needs to be reused else
 * JIT reuse (i.e. the point of the worker strategy) doesn't happen.
 *
 * There are two sensible strategies for Bazel workers A. Each worker compiles multiple Scala versions. Trust the
 * ClassLoaderCache's timestamp check. Maintain a hard reference to the classloader for the last version, and allow
 * previous versions to be GC'ed subject to free memory and -XX:SoftRefLRUPolicyMSPerMB. B. Each worker compiles a
 * single Scala version. Probably still use ClassLoaderCache + hard reference since ClassLoaderCache is hard to remove.
 * The compiler classpath is passed via the initial flags to the worker (rather than the per-request arg file). Bazel
 * worker management cycles out Scala compiler versions. Currently, this runner follows strategy A.
 */
 //format: on
object ZincRunner extends WorkerMain[Namespace] {

  private[this] val classloaderCache = new ClassLoaderCache(new URLClassLoader(Array()))

  private[this] val compilerCache = CompilerCache.fresh

  // prevents GC of the soft reference in classloaderCache
  private[this] var lastCompiler: AnyRef = null

  private[this] def labelToPath(label: String) = Paths.get(label.replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_"))

  protected[this] def init(args: Option[Array[String]]) = {
    val parser = ArgumentParsers.newFor("zinc-worker").addHelp(true).build
    parser.addArgument("--persistence_dir", /* deprecated */ "--persistenceDir").metavar("path")
    parser.addArgument("--use_persistence").`type`(Arg.booleanType)
    parser.addArgument("--extracted_file_cache").metavar("path")
    // deprecated
    parser.addArgument("--max_errors")
    parser.parseArgsOrFail(args.getOrElse(Array.empty))
  }

  private def pathFrom(args: Namespace, name: String): Option[Path] = Option(args.getString(name)).map { dir =>
    Paths.get(dir.replace("~", sys.props.getOrElse("user.home", "")))
  }

  protected[this] def work(worker: Namespace, args: Array[String], out: PrintStream) = {
    val usePersistence: Boolean = worker.getBoolean("use_persistence") match {
      case p: java.lang.Boolean => p
      case null                 => true
    }

    val parser = ArgumentParsers.newFor("zinc").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build()
    CommonArguments.add(parser)
    val namespace = parser.parseArgsOrFail(args)

    val persistenceDir = pathFrom(worker, "persistence_dir")

    val depsCache = pathFrom(worker, "extracted_file_cache")

    val logger = new AnnexLogger(namespace.getString("log_level"), out)

    val tmpDir = namespace.get[File]("tmp").toPath

    // extract srcjars
    val sources = {
      val sourcesDir = tmpDir.resolve("src")
      namespace.getList[File]("sources").asScala ++
        namespace
          .getList[File]("source_jars")
          .asScala
          .zipWithIndex
          .flatMap {
            case (jar, i) => {
              FileUtil.extractZip(jar.toPath, sourcesDir.resolve(i.toString))
            }
          }
          .map(_.toFile)
    }

    // extract upstream classes
    val classesDir = tmpDir.resolve("classes")
    val outputJar = namespace.get[File]("output_jar").toPath

    val deps = {
      val analyses = Option(
        namespace
          .getList[JList[String]]("analysis")
      ).filter(_ => usePersistence)
        .fold[Seq[JList[String]]](Nil)(_.asScala.toSeq)
        .flatMap { value =>
          val prefixedLabel +: apis +: relations +: jars = value.asScala.toList
          val label = prefixedLabel.stripPrefix("_")
          jars
            .map(jar =>
              Paths.get(jar) -> (classesDir
                .resolve(labelToPath(label)), DepAnalysisFiles(Paths.get(apis), Paths.get(relations)))
            )
        }
        .toMap
      val originalClasspath = namespace.getList[File]("classpath").asScala.map(_.toPath)
      Dep.create(depsCache, originalClasspath.toSeq, analyses)
    }

    // load persisted files
    val analysisFiles = AnalysisFiles(
      apis = namespace.get[File]("output_apis").toPath,
      miniSetup = namespace.get[File]("output_setup").toPath,
      relations = namespace.get[File]("output_relations").toPath,
      sourceInfos = namespace.get[File]("output_infos").toPath,
      stamps = namespace.get[File]("output_stamps").toPath
    )
    val analysesFormat = {
      val debug = namespace.getBoolean("debug")
      val format = if (debug) AnxAnalysisStore.TextFormat else AnxAnalysisStore.BinaryFormat
      new AnxAnalyses(format)
    }
    val analysisStore = new AnxAnalysisStore(analysisFiles, analysesFormat)

    val persistence = persistenceDir.fold[ZincPersistence](NullPersistence) { rootDir =>
      val path = namespace.getString("label").replaceAll("^/+", "").replaceAll(raw"[^\w/]", "_")
      new FilePersistence(rootDir.resolve(path), analysisFiles, outputJar)
    }

    val classesOutputDir = classesDir.resolve(labelToPath(namespace.getString("label")))
    try {
      persistence.load()
      if (Files.exists(outputJar)) {
        try FileUtil.extractZip(outputJar, classesOutputDir)
        catch {
          case NonFatal(e) =>
            FileUtil.delete(classesOutputDir)
            throw e
        }
      }
    } catch {
      case NonFatal(e) =>
        logger.warn(() => s"Failed to load cached analysis: $e")
        Files.delete(analysisFiles.apis)
        Files.delete(analysisFiles.miniSetup)
        Files.delete(analysisFiles.relations)
        Files.delete(analysisFiles.sourceInfos)
        Files.delete(analysisFiles.stamps)
    }
    Files.createDirectories(classesOutputDir)

    val previousResult = Try(analysisStore.get())
      .fold(
        { e =>
          logger.warn(() => s"Failed to load previous analysis: $e")
          Optional.empty[AnalysisContents]()
        },
        identity
      )
      .map[PreviousResult](contents =>
        PreviousResult.of(Optional.of(contents.getAnalysis), Optional.of(contents.getMiniSetup))
      )
      .orElseGet(() => PreviousResult.of(Optional.empty[CompileAnalysis](), Optional.empty[MiniSetup]()))

    // setup compiler
    val scalaInstance = new AnnexScalaInstance(namespace.getList[File]("compiler_classpath").asScala.toArray)

    val compileOptions =
      CompileOptions.create
        .withSources(sources.map(source => PlainVirtualFile(source.getAbsoluteFile.toPath)).toArray)
        .withClasspath((classesOutputDir +: deps.map(_.classpath)).map(path => PlainVirtualFile(path)).toArray)
        .withClassesDirectory(classesOutputDir)
        .withJavacOptions(namespace.getList[String]("java_compiler_option").asScala.toArray)
        .withScalacOptions(
          Array.concat(
            namespace.getList[File]("plugins").asScala.map(p => s"-Xplugin:$p").toArray,
            Option(namespace.getList[String]("compiler_option")).fold[Seq[String]](Nil)(_.asScala.toSeq).toArray
          )
        )

    val compilers = {
      val scalaCompiler = ZincUtil
        .scalaCompiler(scalaInstance, namespace.get[File]("compiler_bridge"))
        .withClassLoaderCache(classloaderCache)
      lastCompiler = scalaCompiler
      ZincUtil.compilers(scalaInstance, ClasspathOptionsUtil.boot, None, scalaCompiler)
    }

    val lookup = {
      val depMap = deps.collect { case ExternalDep(_, classpath, files) =>
        classpath -> files
      }.toMap
      new AnxPerClasspathEntryLookup(file => {
        depMap
          .get(file)
          .map(files =>
            Analysis.Empty.copy(
              apis = analysesFormat.apis().read(files.apis),
              relations = analysesFormat.relations.read(files.relations)
            )
          )
      })
    }

    val externalHooks = new DefaultExternalHooks(
      Optional.of(new DeterministicDirectoryHashExternalHooks()),
      Optional.empty()
    )

    val setup = {
      val incOptions = IncOptions
        .create()
        .withAuxiliaryClassFiles(Array(TastyFiles.instance()))
        .withExternalHooks(externalHooks)
      val reporter = new LoggedReporter(logger, scalaInstance.actualVersion)
      val skip = false
      val file: Path = null
      Setup.create(
        lookup,
        skip,
        file,
        compilerCache,
        incOptions,
        reporter,
        Optional.empty[CompileProgress](),
        Array.empty[T2[String, String]]
      )
    }

    val inputs = Inputs.of(compilers, compileOptions, setup, previousResult)

    // compile
    val incrementalCompiler = new IncrementalCompilerImpl()
    val compileResult =
      try incrementalCompiler.compile(inputs, logger)
      catch {
        case _: CompileFailed => sys.exit(-1)
        case e: ClassFormatError =>
          throw new Exception("You may be missing a `macro = True` attribute.", e)
          sys.exit(1)
        case e: StackOverflowError => {
          // Downgrade to NonFatal error.
          // The JVM is not guaranteed to free shared resources correctly when unwinding the stack to catch a StackOverflowError,
          // but since we don't share resources between work threads, this should be mostly safe for us for now.
          // If Bazel could better handle the worker shutting down suddenly, we could allow this to be caught by
          // the UncaughtExceptionHandler in WorkerMain, and exit the entire process to be safe.
          throw new Error("StackOverflowError", e)
        }
      }

    // create analyses
    analysisStore.set(AnalysisContents.create(compileResult.analysis, compileResult.setup))

    // create used deps
    val analysis = compileResult.analysis.asInstanceOf[Analysis]
    val usedDeps =
      deps.filter(Dep.used(deps, analysis.relations, lookup)).filter(_.file != scalaInstance.libraryJar.toPath)
    Files.write(namespace.get[File]("output_used").toPath, usedDeps.map(_.file.toString).sorted.asJava)

    // create jar
    val mains =
      analysis.infos.allInfos.values.toList
        .flatMap(_.getMainClasses.toList)
        .sorted

    val pw = new PrintWriter(namespace.get[File]("main_manifest"))
    try mains.foreach(pw.println)
    finally pw.close()

    val jarCreator = new JarCreator(outputJar)
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

    // save persisted files
    if (usePersistence) {
      try persistence.save()
      catch {
        case NonFatal(e) => logger.warn(() => s"Failed to save cached analysis: $e")
      }
    }

    // clear temporary files
    FileUtil.delete(tmpDir)
    Files.createDirectory(tmpDir)
  }
}

final class AnxPerClasspathEntryLookup(analyses: Path => Option[CompileAnalysis]) extends PerClasspathEntryLookup {
  override def analysis(classpathEntry: VirtualFile): Optional[CompileAnalysis] =
    analyses(PlainVirtualFileConverter.converter.toPath(classpathEntry))
      .fold(Optional.empty[CompileAnalysis])(Optional.of(_))
  override def definesClass(classpathEntry: VirtualFile): DefinesClass =
    Locate.definesClass(classpathEntry)
}

/**
 * We create this to deterministically set the hash code of directories otherwise they get set to the
 * System.identityHashCode() of an object created during compilation. That results in non-determinism.
 */
final class DeterministicDirectoryHashExternalHooks extends ExternalHooks.Lookup {
  // My understanding is that setting all these to None is the same as the
  // default behavior for external hooks, which provides an Optional.empty for
  // the external hooks.
  // The documentation for the getXYZ methods includes:
  // "None if is unable to determine what was changed, changes otherwise"
  // So I figure None is a safe bet here.
  override def getChangedSources(previousAnalysis: CompileAnalysis): Optional[Changes[VirtualFileRef]] =
    Optional.empty()
  override def getChangedBinaries(previousAnalysis: CompileAnalysis): Optional[util.Set[VirtualFileRef]] =
    Optional.empty()
  override def getRemovedProducts(previousAnalysis: CompileAnalysis): Optional[util.Set[VirtualFileRef]] =
    Optional.empty()

  // True here should be a safe default value, based on what I understand.
  // Here's why:
  //
  // There's a guard against this function returning an true incorrectly, so
  // I believe incremental compilation should still function correctly.
  // https://github.com/sbt/zinc/blob/f55b5b5abfba2dfcec0082b6fa8d329286803d2d/internal/zinc-core/src/main/scala/sbt/internal/inc/IncrementalCommon.scala#L186
  //
  // The only other place it's used is linked below. The default is an empty
  // Option, so forall will return true if an ExternalHooks.Lookup is not provided.
  // So this should be the same as default.
  // https://github.com/sbt/zinc/blob/f55b5b5abfba2dfcec0082b6fa8d329286803d2d/internal/zinc-core/src/main/scala/sbt/internal/inc/IncrementalCommon.scala#L429
  override def shouldDoIncrementalCompilation(
    changedClasses: util.Set[String],
    previousAnalysis: CompileAnalysis
  ): Boolean = true

  // We set the hash code of the directories to 0. By default they get set
  // to the System.identityHashCode(), which is dependent on the current execution
  // of the JVM, so it is not deterministic.
  // If Zinc ever changes that behavior, we can get rid of this whole class.
  override def hashClasspath(classpath: Array[VirtualFile]): Optional[Array[FileHash]] = {
    val classpathArrayAsPaths = classpath.map(virtualFile => PlainVirtualFile.extractPath(virtualFile))
    val (directories, files) = classpathArrayAsPaths.partition(path => Files.isDirectory(path))
    val directoryFileHashes = directories.map { path =>
      FileHash.of(path, 0)
    }
    val fileHashes = ClasspathCache.hashClasspath(files)

    Optional.of(directoryFileHashes ++ fileHashes)
  }
}
