package example

import example.CoolInt.*

object MyObject {
  enum Cat {
    case Lion, Tiger, Cheetah
  }

  case class PineappleStand(val cat: Cat, val coolInt: CoolInt)
}
