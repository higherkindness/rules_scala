package annex.specs2

import org.specs2.mutable.Specification

object BadTestThatIsFilteredOut extends Specification {

  "this" should {
    "will not pass" in {
      true must_== false
    }
  }

}
