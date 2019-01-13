package higherkindness.rules_scala
package workers.deps

import common.args.implicits._
import common.worker.WorkerMain

import java.util.Collections
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import scala.collection.JavaConverters._

final case class Caches()

object Caches {
  def empty: Caches = Caches()
}

object PureCompileWorker extends WorkerMain[Caches] {

  override def init(args: Option[Array[String]]): Caches = Caches.empty

  override def work(caches: Caches, rawArgs: Array[String]): Caches = {
    val args = argumentParser.parseArgsOrFail(rawArgs)

    println("args")

    caches
  }

  private[this] val argumentParser = {
    val parser = ArgumentParsers.newFor("pure-compiler").addHelp(true).fromFilePrefix("@").build
    parser
      .addArgument("--pure_bridge")
      .help("Pure compiler bridge")
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
      .addArgument("--compiler_option")
      .help("Compiler option")
      .action(Arguments.append)
      .metavar("option")
    parser
      .addArgument("--classpath")
      .help("Compilation classpath")
      .metavar("path")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead.verifyIsFile)
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--debug")
      .metavar("debug")
      .`type`(Arguments.booleanType)
      .setDefault_(false)
    parser
      .addArgument("--java_compiler_option")
      .help("Java compiler option")
      .action(Arguments.append)
      .metavar("option")
    parser
      .addArgument("--label")
      .help("Bazel label")
      .metavar("label")
    parser
      .addArgument("--log_level")
      .help("Log level")
      .choices(LogLevel.Debug, LogLevel.Error, LogLevel.Info, LogLevel.None, LogLevel.Warn)
      .setDefault_(LogLevel.Warn)
    parser
      .addArgument("--main_manifest")
      .help("List of main entry points")
      .metavar("file")
      .required(true)
      .`type`(Arguments.fileType.verifyCanCreate)
    parser
      .addArgument("--output_jar")
      .help("Output jar")
      .metavar("path")
      .required(true)
      .`type`(Arguments.fileType.verifyCanCreate())
    parser
      .addArgument("--output_used")
      .help("Output list of used jars")
      .metavar("path")
      .required(true)
      .`type`(Arguments.fileType.verifyCanCreate)
    parser
      .addArgument("--plugins")
      .help("Compiler plugins")
      .metavar("path")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead)
      .setDefault_(Collections.emptyList)
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
      .addArgument("sources")
      .help("Source files")
      .metavar("source")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead.verifyIsFile)
      .setDefault_(Collections.emptyList)
    parser
  }

}

object LogLevel {
  val Debug = "debug"
  val Error = "error"
  val Info = "info"
  val None = "none"
  val Warn = "warn"
}
