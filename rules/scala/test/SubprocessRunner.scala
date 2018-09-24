package annex

import java.io.ObjectInputStream
import java.nio.file.Paths
import java.net.URLClassLoader
import java.nio.file.Path
import sbt.testing.Logger
import scala.collection.mutable

class TestRequest(
  val framework: String,
  val test: TestDefinition,
  val scopeAndTestName: String,
  val classpath: Seq[String],
  val logger: Logger with Serializable
) extends Serializable

object SubprocessTestRunner {

  def main(args: Array[String]): Unit = {
    val input = new ObjectInputStream(System.in)
    val request = input.readObject().asInstanceOf[TestRequest]

    val classLoader = new URLClassLoader(request.classpath.map(path => Paths.get(path).toUri.toURL).toArray)

    val loader = new TestFrameworkLoader(classLoader, request.logger)
    val framework = loader.load(request.framework).get

    val success = ClassLoader.withContextClassLoader(classLoader) {
      TestFrameworkRunner.withRunner(framework, request.scopeAndTestName, classLoader) { runner =>
        val tasks = runner.tasks(Array(TestFrameworkRunner.taskDef(request.test, request.scopeAndTestName)))
        tasks.length == 0 || {
          val reporter = new TestReporter(request.logger)
          val taskExecutor = new TestTaskExecutor(request.logger)
          val failures = mutable.Set[String]()
          tasks.foreach { task =>
            reporter.preTask(task)
            taskExecutor.execute(task, failures)
            reporter.postTask()
          }
          !failures.nonEmpty
        }
      }
    }

    if (!success) {
      sys.exit(1)
    }
  }

}
