package annex

object ClassLoader {
  def withContextClassLoader[A](classLoader: ClassLoader)(f: => A) = {
    val thread = Thread.currentThread
    val previous = thread.getContextClassLoader
    thread.setContextClassLoader(classLoader)
    try f
    finally thread.setContextClassLoader(previous)
  }
}
