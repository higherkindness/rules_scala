import org.specs2.mutable.Specification

object ContextTest extends Specification {

  class Item

  "Context classpath" should {
    "load class" in {
      Thread.currentThread.getContextClassLoader.loadClass(classOf[Item].getName) must_== classOf[Item]
    }
  }

}
