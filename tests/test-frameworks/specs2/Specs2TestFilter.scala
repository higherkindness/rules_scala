package annex.specs2

import org.specs2.mutable.Specification

object Specs2TestFilter extends Specification {
  "scala_test" should {
    "properly (escape) [special] characters in the test filter" in {
      1 must_== 1
    }
  }
}
