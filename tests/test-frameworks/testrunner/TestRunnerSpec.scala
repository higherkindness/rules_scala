package annex.specs2

import org.specs2.mutable.Specification

object TestRunnerSpec extends Specification {

  "args" should {
    "be parsed" in {
      true must_== true
    }
  }

}
