package doof

object Foo {
  def main(args: Array[String]): Unit = {
    val line = implicitly[sourcecode.Line]
    assert(line.value == 6)
  }
}
