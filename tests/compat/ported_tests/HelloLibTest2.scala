package scala.test

import org.scalatest._

object TestUtil2 {
  def foo: String = "bar"
}

class ScalaSuite2 extends FlatSpec {
  "HelloLib" should "call scala" in {
    assert(HelloLib.getOtherLibMessage("hello").equals("hello you all, everybody. I am Runtime"))
  }
}

class JavaSuite2 extends FlatSpec {
  "HelloLib" should "call java" in {
    assert(HelloLib.getOtherJavaLibMessage("hello").equals("hello java!"))
  }
}
