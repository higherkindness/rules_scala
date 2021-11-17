object UnionTypes:
  sealed trait Number
  final case class One(i: Int) extends Number
  final case class Two(i: Int) extends Number

  type OneOrTwo = One | Two