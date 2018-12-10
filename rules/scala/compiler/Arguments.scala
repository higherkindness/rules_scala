package annex.compiler

import higherkindness.rules_scala.common.args.implicits._
import java.util.Collections
import net.sourceforge.argparse4j.impl.{Arguments => ArgumentsImpl}
import net.sourceforge.argparse4j.inf.ArgumentParser

object Arguments {

  object LogLevel {
    val Debug = "debug"
    val Error = "error"
    val Info = "info"
    val None = "none"
    val Warn = "warn"
  }

  def add(parser: ArgumentParser): Unit = {
    parser
      .addArgument("--analysis")
      .action(ArgumentsImpl.append)
      .help("Analysis, given as: label apis relations [jar ...]")
      .metavar("args")
      .nargs("*")
    parser
      .addArgument("--compiler_bridge")
      .help("Compiler bridge")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanRead().verifyIsFile())
    parser
      .addArgument("--compiler_classpath")
      .help("Compiler classpath")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead().verifyIsFile())
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--compiler_option")
      .help("Compiler option")
      .action(ArgumentsImpl.append)
      .metavar("option")
    parser
      .addArgument("--classpath")
      .help("Compilation classpath")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead.verifyIsFile)
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--debug")
      .metavar("debug")
      .`type`(ArgumentsImpl.booleanType)
      .setDefault_(false)
    parser
      .addArgument("--java_compiler_option")
      .help("Java compiler option")
      .action(ArgumentsImpl.append)
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
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--output_apis")
      .help("Output APIs")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate())
    parser
      .addArgument("--output_infos")
      .help("Output Zinc source infos")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate())
    parser
      .addArgument("--output_jar")
      .help("Output jar")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate())
    parser
      .addArgument("--output_relations")
      .help("Output Zinc relations")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate())
    parser
      .addArgument("--output_setup")
      .help("Output Zinc setup")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate())
    parser
      .addArgument("--output_stamps")
      .help("Output Zinc source stamps")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate())
    parser
      .addArgument("--output_used")
      .help("Output list of used jars")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--plugins")
      .help("Compiler plugins")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead)
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--source_jars")
      .help("Source jars")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead().verifyIsFile())
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--tmp")
      .help("Temporary directory")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType)
    parser
      .addArgument("sources")
      .help("Source files")
      .metavar("source")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead.verifyIsFile)
      .setDefault_(Collections.emptyList)
  }

}
