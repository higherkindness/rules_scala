import org.specs2.mutable.Specification

class IndirectUnused extends Specification {

  "Equality" should {
    "be reflexive" in {
      val a = 1
      a must_== a
    }
  }

}
