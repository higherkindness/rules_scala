trait Bind[F[_]] {
  def map[A, B](fa: F[A])(f: A => B): F[B]
  def flatMap[A, B](fa: F[A])(f: A => F[B]): F[B]
}

object Example {
  def tupleTC[F[_], A, B](fa: F[A], fb: F[B])(implicit F: Bind[F]): F[(A, B)] =
    F.flatMap(fa)(a => F.map(fb)((a, _)))
}
