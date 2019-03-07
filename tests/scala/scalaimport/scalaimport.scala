// This is a test for the correctness of scala_import. It intends to import
// 3rdparty dependencies.

import shapeless._

object Test {

    type T = Int :: HNil

    def main(args: Array[String]): Unit = {
        val xml = <things><thing1></thing1><thing2></thing2></things>
    }
}
