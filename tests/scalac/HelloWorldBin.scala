package anx

object HelloWorld extends Hello with World {
  def main(args: Array[String]): Unit = {
    println(s"${decode(this.hello)} ${decode(this.world)}")
    assert(decode(this.hello) == "hello")
    assert(decode(this.world) == "world")
  }

  private def decode(input: String): String =
    input.zipWithIndex
      .map { case (c, i) => (c - i).toChar }
      .mkString
}
