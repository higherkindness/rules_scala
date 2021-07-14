package higherkindness.rules_scala
package workers.common

import higherkindness.rules_scala.workers.common.Color
import xsbti.{Logger, Problem}
import sbt.internal.inc.{LoggedReporter => SbtLoggedReporter}
import scala.util.Try

class LoggedReporter(logger: Logger, versionString: String) extends SbtLoggedReporter(0, logger) {
  // Scala 3 has great error messages, let's leave those alone, but still add color to the Scala 2 messages
  val shouldEnhanceMessage = if (versionString.startsWith("0.") || versionString.startsWith("3")) false else true

  def doLog(problem: Problem, colorFunc: Problem => String): String = {
    if (shouldEnhanceMessage) {
      colorFunc(problem)
    } else {
      problem.rendered().orElse(problem.toString)
    }
  }

  override protected def logError(problem: Problem): Unit = {
    logger.error(() => doLog(problem, Color.Error))
  }
  override protected def logInfo(problem: Problem): Unit = {
    logger.info(() => doLog(problem, Color.Info))
  }
  override protected def logWarning(problem: Problem): Unit = {
    logger.warn(() => doLog(problem, Color.Warning))
  }
}
