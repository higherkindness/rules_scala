package annex.doc

import annex.args.Implicits._
import annex.compiler.{AnxLogger, AnxScalaInstance, FileUtil}
import annex.compiler.Arguments.LogLevel
import annex.worker.SimpleMain
import java.io.{File, PrintWriter}
import java.net.URLClassLoader
import java.nio.file._
import java.util.function.Supplier
import java.util.zip.ZipInputStream
import java.util.{Collections, Optional, Properties}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.ArgumentParser
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

object DocRunner extends SimpleMain {

  private[this] val classloaderCache = new ClassLoaderCache(null)

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

  def work(args: Array[String]): Unit = {
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

    val scalaInstance = new AnxScalaInstance(namespace.getList[File]("compiler_classpath").asScala.toArray)

    val logger = new AnxLogger(namespace.getString("log_level"))

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
