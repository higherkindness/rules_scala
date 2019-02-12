import org.junit.Test
import org.junit.Assert._

class JUnitTests {

  @Test
  def testMethodA: Unit = {
    assert(A.methodA(true) == B)
  }

}
