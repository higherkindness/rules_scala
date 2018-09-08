package annex.bloop

import annex.worker.SimpleMain
import bloop.Bloop

object BloopRunner extends SimpleMain {
  protected[this] def work(args: Array[String]): Unit = Bloop
}
