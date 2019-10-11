package higherkindness.rules_scala
package workers.common

import xsbti.{Logger, Problem}
import sbt.internal.inc.{LoggedReporter => SbtLoggedReporter}

class LoggedReporter(logger: Logger) extends SbtLoggedReporter(0, logger) {
  override protected def logError(problem: Problem): Unit = logger.error(() => Color.Error(problem))
  override protected def logInfo(problem: Problem): Unit = logger.info(() => Color.Info(problem))
  override protected def logWarning(problem: Problem): Unit = logger.warn(() => Color.Warning(problem))
}
