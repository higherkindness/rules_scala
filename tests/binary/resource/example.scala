import scala.io.Source

object Example {
  def main(args: Array[String]): Unit = {
    val stream = getClass.getResourceAsStream("/example.txt")
    for (line <- Source.fromInputStream(stream).getLines()) {
      println(line)
    }
  }
}
