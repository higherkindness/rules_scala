import org.specs2.mutable.Specification

object Test3 extends Specification {
  "-Dexample" should {
    "exist" in {
      sys.props += "example" -> "value"
      sys.props.get("example") must beSome("value")
    }
  }
}

object Test4 extends Specification {
  "-Dexample" should {
    "not exist" in {
      sys.props.get("example") must beNone
    }
  }
}
