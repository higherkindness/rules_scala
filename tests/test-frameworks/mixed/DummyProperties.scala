package annex.scalacheck

import org.scalacheck._

class DummyProperties extends Properties("Dummy") {
  property("foo") = true
  property("bar") = true
}

object Doof {
  def main(args: Array[String]): Unit = {
    println("lol")
  }
}
