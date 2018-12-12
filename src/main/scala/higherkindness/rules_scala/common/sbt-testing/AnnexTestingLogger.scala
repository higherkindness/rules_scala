package higherkindness.rules_scala
package common.sbt_testing

import sbt.testing.Logger

final class AnnexTestingLogger(color: Boolean, verbosity: String) extends Logger with Serializable {
  def ansiCodesSupported = color

  def error(msg: String) = println(s"$msg")

  def warn(msg: String) = println(s"$msg")

  def info(msg: String) = verbosity match {
    case "HIGH" | "MEDIUM" => println(s"$msg")
    case _                 =>
  }

  def debug(msg: String) = verbosity match {
    case "HIGH" => println(s"$msg")
  }

  def trace(err: Throwable) = println(s"${err.getMessage}")
}
