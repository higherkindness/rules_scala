package annex.specs2

import org.specs2.mutable.Specification

object Specs2TestFilter extends Specification {
  "scala_test" should {
    "properly (escape) [special] characters in the test filter" in {
      true must beTrue
    }

    "handle tests without scopes" in {
      true must beTrue
    }

    "test with :: in name" in {
      true must beTrue
    }

    "other test with :: in name" in {
      true must beTrue
    }
  }
}
