package higherkindness.rules_scala
package workers.common

import xsbti.Logger

import java.io.{PrintStream, PrintWriter, StringWriter}
import java.nio.file.Paths
import java.util.function.Supplier

import CommonArguments.LogLevel

final class AnnexLogger(level: String, out: PrintStream = System.err) extends Logger {

  private[this] val root = s"${Paths.get("").toAbsolutePath}/"

  private[this] def format(value: String): String = value.replace(root, "")

  def debug(msg: Supplier[String]): Unit = level match {
    case LogLevel.Debug => out.println(format(msg.get))
    case _              =>
  }

  def error(msg: Supplier[String]): Unit = level match {
    case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn => out.println(format(msg.get))
    case _                                                               =>
  }

  def info(msg: Supplier[String]): Unit = level match {
    case LogLevel.Debug | LogLevel.Info => out.println(format(msg.get))
    case _                              =>
  }

  def trace(err: Supplier[Throwable]): Unit = level match {
    case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn =>
      val trace = new StringWriter();
      err.get.printStackTrace(new PrintWriter(trace));
      out.println(format(trace.toString))
    case _ =>
  }

  def warn(msg: Supplier[String]): Unit = level match {
    case LogLevel.Debug | LogLevel.Info | LogLevel.Warn => out.println(format(msg.get))
    case _                                              =>
  }

}
