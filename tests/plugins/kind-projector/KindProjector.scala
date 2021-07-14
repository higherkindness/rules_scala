package anx

object Test {
  trait PolyFunction1[-F[_], +G[_]] {
    def apply[A](fa: F[A]): G[A]
  }

  val firstGeneric0: PolyFunction1[List, Option] =
    new PolyFunction1[List, Option] {
      def apply[A](xs: List[A]): Option[A] = xs.headOption
    }
}