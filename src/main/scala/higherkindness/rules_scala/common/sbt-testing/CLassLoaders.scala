package higherkindness.rules_scala
package common.sbt_testing

import java.net.{URL, URLClassLoader}

object ClassLoaders {
  def withContextClassLoader[A](classLoader: ClassLoader)(f: => A) = {
    val thread = Thread.currentThread
    val previous = thread.getContextClassLoader
    thread.setContextClassLoader(classLoader)
    try f
    finally thread.setContextClassLoader(previous)
  }

  def sbtTestClassLoader(urls: Seq[URL]) = new URLClassLoader(urls.toArray, ClassLoader.getPlatformClassLoader()) {
    private[this] val current = getClass.getClassLoader()
    override protected def findClass(className: String): Class[_] =
      if (className.startsWith("sbt.testing.")) current.loadClass(className)
      else if (className.startsWith("org.jacoco.agent.rt.")) current.loadClass(className)
      else super.findClass(className)
  }
}
