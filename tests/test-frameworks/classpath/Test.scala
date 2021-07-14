import org.specs2.mutable.Specification

object Test extends Specification {

  "Classpath" should {
    "load class" in {
      getClass.getClassLoader.loadClass("sbt.internal.inc.Schema$APIsFile")
      ok
    }
  }

}
