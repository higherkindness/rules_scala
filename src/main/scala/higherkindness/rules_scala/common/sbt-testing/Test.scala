package higherkindness.rules_scala
package common.sbt_testing

import sbt.testing.{Event, Fingerprint, Framework, Logger, Runner, Status, Task, TaskDef, TestWildcardSelector}
import scala.collection.mutable
import scala.util.control.NonFatal

class TestDefinition(val name: String, val fingerprint: Fingerprint with Serializable) extends Serializable

class TestFrameworkLoader(loader: ClassLoader, logger: Logger) {
  def load(className: String) = {
    val framework =
      try {
        Some(Class.forName(className, true, loader).getDeclaredConstructor().newInstance())
      } catch {
        case _: ClassNotFoundException => None
        case NonFatal(e)               => throw new Exception(s"Failed to load framework $className", e)
      }
    framework.map {
      case framework: Framework => framework
      case _                    => throw new Exception(s"$className does not implement ${classOf[Framework].getName}")
    }

  }
}

object TestHelper {
  def withRunner[A](framework: Framework, scopeAndTestName: String, classLoader: ClassLoader, arguments: Seq[String])(
    f: Runner => A
  ) = {
    val options =
      if (framework.name == "specs2") Array("-ex", scopeAndTestName.replaceAll(".*::", "")) else Array.empty[String]
    val runner = framework.runner(arguments.toArray, options, classLoader)
    try f(runner)
    finally runner.done()
  }

  def taskDef(test: TestDefinition, scopeAndTestName: String) =
    new TaskDef(
      test.name,
      test.fingerprint,
      false,
      Array(new TestWildcardSelector(scopeAndTestName.replace("::", " ")))
    )
}

class TestReporter(logger: Logger) {
  def post(failures: Traversable[String]) = if (failures.nonEmpty) {
    logger.error(s"${failures.size} ${if (failures.size == 1) "failure" else "failures"}:")
    failures.toSeq.sorted.foreach(name => logger.error(s"    $name"))
    logger.error("")
  }

  def postTask() = logger.info("")

  def pre(framework: Framework, tasks: Traversable[Task]) = {
    logger.info(s"${framework.getClass.getName}: ${tasks.size} tests")
    logger.info("")
  }

  def preTask(task: Task) = logger.info(task.taskDef.fullyQualifiedName)
}

class TestTaskExecutor(logger: Logger) {
  def execute(task: Task, failures: mutable.Set[String]): mutable.ListBuffer[Event] = {
    var events = new mutable.ListBuffer[Event]()
    def execute(task: Task): Unit = {
      val tasks = task.execute(
        event => {
          events += event
          event.status match {
            case Status.Failure | Status.Error =>
              failures += task.taskDef.fullyQualifiedName
            case _ =>
          }
        },
        Array(new PrefixedTestingLogger(logger, "    "))
      )
      tasks.foreach(execute)
    }
    execute(task)
    events
  }
}
