package higherkindness.rules_scala
package workers.zinc.doc

import common.args.implicits._
import common.worker.WorkerMain
import workers.common.AnnexLogger
import workers.common.AnnexScalaInstance
import workers.common.CommonArguments.LogLevel
import workers.common.FileUtil

import java.io.File
import java.net.URLClassLoader
import java.nio.file.{Files, NoSuchFileException}
import java.util.{Collections, Optional, Properties}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.Namespace
import sbt.internal.inc.classpath.ClassLoaderCache
import sbt.internal.inc.{LoggedReporter, ZincUtil}
import scala.collection.JavaConverters._
import xsbti.Logger

object DocRunner extends WorkerMain[Unit] {

  private[this] val classloaderCache = new ClassLoaderCache(new URLClassLoader(Array()))

  private[this] val parser =
    ArgumentParsers.newFor("doc").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build()
  parser
    .addArgument("--classpath")
    .help("Compilation classpath")
    .metavar("path")
    .nargs("*")
    .`type`(Arguments.fileType.verifyCanRead.verifyIsFile)
    .setDefault_(Collections.emptyList)
  parser
    .addArgument("--compiler_bridge")
    .help("Compiler bridge")
    .metavar("path")
    .required(true)
    .`type`(Arguments.fileType.verifyCanRead().verifyIsFile())
  parser
    .addArgument("--compiler_classpath")
    .help("Compiler classpath")
    .metavar("path")
    .nargs("*")
    .`type`(Arguments.fileType.verifyCanRead().verifyIsFile())
    .setDefault_(Collections.emptyList)
  parser
    .addArgument("--option")
    .help("option")
    .action(Arguments.append)
    .metavar("option")
  parser
    .addArgument("--log_level")
    .help("Log level")
    .choices(LogLevel.Debug, LogLevel.Error, LogLevel.Info, LogLevel.None, LogLevel.Warn)
    .setDefault_(LogLevel.Warn)
  parser
    .addArgument("--source_jars")
    .help("Source jars")
    .metavar("path")
    .nargs("*")
    .`type`(Arguments.fileType.verifyCanRead().verifyIsFile())
    .setDefault_(Collections.emptyList)
  parser
    .addArgument("--tmp")
    .help("Temporary directory")
    .metavar("path")
    .required(true)
    .`type`(Arguments.fileType)
  parser
    .addArgument("--output_html")
    .help("Output directory")
    .metavar("path")
    .required(true)
    .`type`(Arguments.fileType)
  parser
    .addArgument("sources")
    .help("Source files")
    .metavar("source")
    .nargs("*")
    .`type`(Arguments.fileType.verifyCanRead.verifyIsFile)
    .setDefault_(Collections.emptyList)

  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit = {
    val namespace = parser.parseArgsOrFail(args)

    val tmpDir = namespace.get[File]("tmp").toPath
    try FileUtil.delete(tmpDir)
    catch { case _: NoSuchFileException => }

    val sources = namespace.getList[File]("sources").asScala ++
      namespace
        .getList[File]("source_jars")
        .asScala
        .zipWithIndex
        .flatMap {
          case (jar, i) => FileUtil.extractZip(jar.toPath, tmpDir.resolve("src").resolve(i.toString))
        }
        .map(_.toFile)

    val scalaInstance = new AnnexScalaInstance(namespace.getList[File]("compiler_classpath").asScala.toArray)

    val logger = new AnnexLogger(namespace.getString("log_level"))

    val scalaCompiler = ZincUtil
      .scalaCompiler(scalaInstance, namespace.get[File]("compiler_bridge"))
      .withClassLoaderCache(classloaderCache)

    val classpath = namespace.getList[File]("classpath").asScala.toSeq
    val output = namespace.get[File]("output_html")
    output.mkdirs()
    val options = Option(namespace.getList[String]("option")).fold[Seq[String]](Nil)(_.asScala).toSeq
    val reporter = new LoggedReporter(10, logger)
    scalaCompiler.doc(sources, scalaInstance.libraryJar +: classpath, output, options, logger, reporter)

    try FileUtil.delete(tmpDir)
    catch { case _: NoSuchFileException => }
    Files.createDirectory(tmpDir)
  }
}
