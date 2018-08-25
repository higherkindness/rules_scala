package annex.args

import net.sourceforge.argparse4j.inf.Argument

object Implicits {

  implicit class SetArgumentDefault(val argument: Argument) extends AnyVal {
    import scala.language.reflectiveCalls

    // https://issues.scala-lang.org/browse/SI-2991
    private[this] type SetDefault = { def setDefault(value: AnyRef) }

    def setDefault_[A](value: A) = argument.asInstanceOf[SetDefault].setDefault(value.asInstanceOf[AnyRef])
  }

}
