package annex.worker

trait SimpleMain extends WorkerMain[Unit] {

  protected[this] def init(args: Option[Array[String]]) = ()

  protected[this] def work(state: Unit, args: Array[String]) = work(args)

  protected[this] def work(args: Array[String])

}
