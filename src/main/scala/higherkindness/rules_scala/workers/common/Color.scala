package higherkindness.rules_scala
package workers.common

import xsbti.Problem
import Console.{GREEN => CG, RED => CR, RESET => CRESET, YELLOW => CY}

object Color {
  def Info(problem: Problem): String = colorProblem(problem, CG)

  def Info(message: String): String = colorString(message, CG, "Info")

  def Warning(problem: Problem): String = colorProblem(problem, CY)

  def Warning(message: String): String = colorString(message, CY, "Warn")

  def Error(problem: Problem): String = colorProblem(problem, CR)

  def Error(message: String): String = colorString(message, CR, "Error")

  private def colorProblem(problem: Problem, color: String): String = {
    val header = s"[$color${problem.severity}$CRESET]"
    problem.position.toString.size match {
      case 0 => s"$header " + problem.message.replaceAll("\n", s"\n$header ")
      case _ => s"$header ${problem.position} " + problem.message.replaceAll("\n", s"\n$header ")
    }
  }

  private def colorString(message: String, color: String, severity: String): String = {
    val header = s"[$color$severity$CRESET]"
    s"$header " + message.replaceAll("\n", s"\n$header ")
  }
}
