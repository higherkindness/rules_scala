package higherkindness.rules_scala
package common.args

import scala.language.reflectiveCalls
import net.sourceforge.argparse4j.inf.Argument

object implicits {
  implicit final class SetArgumentDefault(val argument: Argument) extends AnyVal {
    // https://issues.scala-lang.org/browse/SI-2991
    private[this] type SetDefault = { def setDefault(value: AnyRef) }
    def setDefault_[A](value: A) = argument.asInstanceOf[SetDefault].setDefault(value.asInstanceOf[AnyRef])
  }
}
