package higherkindness.rules_scala
package workers.common

import xsbti.{Logger, Position, Problem, Reporter, Severity}
import Severity.{Error, Info, Warn}
import sbt.util.InterfaceUtil.{toSupplier => spl}
import scala.collection.mutable.ListBuffer

class LoggedReporter(
  maximumErrors: Int,
  logger: Logger
) extends Reporter {
  private val problemCount = new ListBuffer[Problem]
  reset

  def reset = problemCount.clear
  def hasErrors = errorCount > 0
  def hasWarnings = warningCount > 0
  def problems = problemCount.toArray
  def comment(pos: Position, msg: String) = ()

  def printSummary = {
    if (hasWarnings) logger.warn(spl(Color.Warning(elementCountToString(warningCount, "warning"))))
    if (hasErrors) logger.error(spl(Color.Error(elementCountToString(errorCount, "error"))))
  }

  override def log(problem: Problem) = {
    problemCount += problem
    val severity = problem.severity
    if (severity != Error || maximumErrors <= 0 || errorCount <= maximumErrors) {
      severity match {
        case Error => logger.error(spl(Color.Error(problem)))
        case Warn  => logger.warn(spl(Color.Warning(problem)))
        case Info  => logger.info(spl(Color.Info(problem)))
      }
    }
  }

  private def errorCount = problemCount.count(_.severity == Error)
  private def warningCount = problemCount.count(_.severity == Warn)
  private def elementCountToString(num: Int, element: String) = s"${num} ${element}${if (num > 1) "s" else ""} found"
}
