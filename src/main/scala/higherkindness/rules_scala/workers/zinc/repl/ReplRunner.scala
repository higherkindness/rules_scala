package higherkindness.rules_scala
package workers.zinc.repl

import common.args.implicits._
import workers.zinc.common.CommonArguments.LogLevel
import workers.zinc.common.AnnexLogger
import workers.zinc.common.AnnexScalaInstance
import workers.zinc.common.FileUtil

import java.io.File
import java.nio.file.{Files, Paths}
import java.util.Collections
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import sbt.internal.inc.ZincUtil
import scala.collection.JavaConverters._
import xsbti.Logger

object ReplRunner {

  private[this] val argParser =
    ArgumentParsers.newFor("repl").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build()
  argParser
    .addArgument("--log_level")
    .help("Log level")
    .choices(LogLevel.Debug, LogLevel.Error, LogLevel.Info, LogLevel.None, LogLevel.Warn)
    .setDefault_(LogLevel.Warn)

  private[this] val replArgParser =
    ArgumentParsers.newFor("repl-args").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build()
  replArgParser
    .addArgument("--classpath")
    .help("Compilation classpath")
    .metavar("path")
    .nargs("*")
    .`type`(Arguments.fileType)
    .setDefault_(Collections.emptyList)
  replArgParser
    .addArgument("--compiler_bridge")
    .help("Compiler bridge")
    .metavar("path")
    .required(true)
    .`type`(Arguments.fileType)
  replArgParser
    .addArgument("--compiler_classpath")
    .help("Compiler classpath")
    .metavar("path")
    .nargs("*")
    .`type`(Arguments.fileType)
    .setDefault_(Collections.emptyList)
  replArgParser
    .addArgument("--compiler_option")
    .help("Compiler option")
    .action(Arguments.append)
    .metavar("option")

  def main(args: Array[String]): Unit = {
    val namespace = argParser.parseArgsOrFail(args)

    val runPath = Paths.get(sys.props("bazel.runPath"))

    val replArgFile = Paths.get(sys.props("scalaAnnex.test.args"))
    val replNamespace = replArgParser.parseArgsOrFail(Files.readAllLines(replArgFile).asScala.toArray)

    val urls =
      replNamespace
        .getList[File]("classpath")
        .asScala
        .map(file => runPath.resolve(file.toPath).toUri.toURL)

    val compilerClasspath = replNamespace
      .getList[File]("compiler_classpath")
      .asScala
      .map(file => runPath.resolve(file.toPath).toFile)
    val scalaInstance = new AnnexScalaInstance(
      compilerClasspath.toArray
    )

    val logger = new AnnexLogger(namespace.getString("log_level"))

    val scalaCompiler = ZincUtil
      .scalaCompiler(scalaInstance, runPath.resolve(replNamespace.get[File]("compiler_bridge").toPath).toFile)

    val classpath = replNamespace
      .getList[File]("classpath")
      .asScala
      .map(file => runPath.resolve(file.toPath).toFile)
      .toSeq

    val options = Option(replNamespace.getList[String]("compiler_option")).fold[Seq[String]](Nil)(_.asScala).toSeq
    scalaCompiler.console(compilerClasspath ++ classpath, options, "", "", logger)()
  }
}
