package annex

import java.net.{URL, URLClassLoader}

object ClassLoader {
  def withContextClassLoader[A](classLoader: ClassLoader)(f: => A) = {
    val thread = Thread.currentThread
    val previous = thread.getContextClassLoader
    thread.setContextClassLoader(classLoader)
    try f
    finally thread.setContextClassLoader(previous)
  }

  def sbtTestClassLoader(urls: Seq[URL]) = new URLClassLoader(urls.toArray, null) {
    private[this] val current = getClass.getClassLoader()
    override protected def findClass(className: String): Class[_] =
      if (className.startsWith("sbt.testing.")) current.loadClass(className) else super.findClass(className)
  }
}
