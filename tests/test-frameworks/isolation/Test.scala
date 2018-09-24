import org.specs2.mutable.Specification

object Test1 extends Specification {
  "Global" should {
    "be 2" in {
      Global.value = 2
      Global.value must_== 2
    }
  }
}

object Test2 extends Specification {
  "Global" should {
    "be 1" in {
      Global.value must_== 1
    }
  }
}
