package annex.compiler

import annex.compiler.Arguments.LogLevel
import java.util.function.Supplier
import xsbti.Logger

final class AnxLogger(level: String) extends Logger {

  def debug(msg: Supplier[String]) = level match {
    case LogLevel.Debug => System.err.println(msg.get)
    case _              =>
  }

  def error(msg: Supplier[String]) = level match {
    case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn => println(msg.get)
    case _                                                               =>
  }

  def info(msg: Supplier[String]) = level match {
    case LogLevel.Debug | LogLevel.Info => System.err.println(msg.get)
    case _                              =>
  }

  def trace(err: Supplier[Throwable]) = level match {
    case LogLevel.Debug | LogLevel.Error | LogLevel.Info | LogLevel.Warn => err.get.printStackTrace()
    case _                                                               =>
  }

  def warn(msg: Supplier[String]) = level match {
    case LogLevel.Debug | LogLevel.Info | LogLevel.Warn => System.err.println(msg.get)
    case _                                              =>
  }

}
