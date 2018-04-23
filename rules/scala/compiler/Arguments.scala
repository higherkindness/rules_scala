package annex.compiler

import net.sourceforge.argparse4j.impl.{Arguments => ArgumentsImpl}
import net.sourceforge.argparse4j.inf.{Argument, ArgumentParser}

object Arguments {

  object LogLevel {
    val Debug = "debug"
    val Error = "error"
    val Info = "info"
    val None = "none"
    val Warn = "warn"
  }

  implicit class SetDefault(argument: Argument) {
    import scala.language.reflectiveCalls

    // https://issues.scala-lang.org/browse/SI-2991
    private[this] type SetDefault = { def setDefault(value: AnyRef) }

    def setDefault_[A](value: A) = argument.asInstanceOf[SetDefault].setDefault(value.asInstanceOf[AnyRef])
  }

  def add(parser: ArgumentParser): Unit = {
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
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanRead().verifyIsFile())
    parser
      .addArgument("--classpath")
      .help("Compilation classpath")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead.verifyIsFile)
    parser
      .addArgument("--debug")
      .metavar("debug")
      .`type`(ArgumentsImpl.booleanType)
      .setDefault_(false)
    parser
      .addArgument("--direct_classpath")
      .help("Classpath of direct dependencies")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead.verifyIsFile)
    parser
      .addArgument("--label")
      .help("Bazel label")
      .metavar("label")
    parser
      .addArgument("--log_level")
      .help("Log level")
      .choices(LogLevel.Debug, LogLevel.Error, LogLevel.Info, LogLevel.None, LogLevel.Warn)
      .setDefault_(LogLevel.Info)
    parser
      .addArgument("--main_manifest")
      .help("List of main entry points")
      .metavar("file")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--output_analysis")
      .help("Output analysis")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--output_apis")
      .help("Output APIs")
      .metavar("path")
      .required(true)
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--output_jar")
      .help("Output jar")
      .metavar("path")
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--plugins")
      .help("Compiler plugins")
      .metavar("path")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanCreate)
    parser
      .addArgument("--require_direct")
      .help("Fail if indirect dependencies are used by sources")
      .`type`(ArgumentsImpl.booleanType)
      .setDefault_(false)
    parser
      .addArgument("--require_used")
      .help("Fail if direct dependencies are unused")
      .`type`(ArgumentsImpl.booleanType)
      .setDefault_(false)
    parser
      .addArgument("sources")
      .help("Source files")
      .metavar("source")
      .nargs("*")
      .`type`(ArgumentsImpl.fileType.verifyCanRead.verifyIsFile)
  }

}
