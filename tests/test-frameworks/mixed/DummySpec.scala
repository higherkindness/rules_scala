package annex.specs2

import org.scalatest._
import java.util.{EmptyStackException, Stack}

class DummySpec extends FlatSpec with Matchers {

  "A Stack" should "pop values in last-in-first-out order" in {
    val stack = new Stack[Int]
    stack.push(1)
    stack.push(2)
    stack.pop() should be(2)
    stack.pop() should be(1)
  }

  it should "throw EmptyStackException if an empty stack is popped" in {
    val emptyStack = new Stack[Int]
    a[EmptyStackException] should be thrownBy emptyStack.pop()
  }
}
