package example

import example.Pineapples

object MyScalaClass {
 def main(args: Array[String]): Unit = {
  println(Pineapples.theGood.cat, Pineapples.theGood.coolInt)
  println(Pineapples.theBad.cat, Pineapples.theBad.coolInt)
 }
}
