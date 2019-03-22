import org.junit.Test
import org.junit.Assert._

class TestAll {

  @Test
  def testA1: Unit = {
    assert(A1.a1(true) == B1)
  }

  @Test
  def testA2: Unit = {
    A2.a2()
  }

}
