package higherkindness.rules_scala
package workers.zinc.test

import common.sbt_testing.ClassLoaders
import common.sbt_testing.JUnitXmlReporter
import common.sbt_testing.TestDefinition
import common.sbt_testing.TestFrameworkLoader
import common.sbt_testing.TestHelper
import common.sbt_testing.TestReporter
import common.sbt_testing.TestRequest
import common.sbt_testing.TestTaskExecutor

import java.io.PrintWriter
import java.io.ObjectOutputStream
import java.nio.file.Path
import sbt.testing.{Event, Framework, Logger}
import scala.collection.mutable

class BasicTestRunner(framework: Framework, classLoader: ClassLoader, logger: Logger) extends TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) = {
    var tasksAndEvents = new mutable.ListBuffer[(String, mutable.ListBuffer[Event])]()
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        val reporter = new TestReporter(logger)
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
        val taskExecutor = new TestTaskExecutor(logger)
        val failures = mutable.Set[String]()
        tasks.foreach { task =>
          reporter.preTask(task)
          val events = taskExecutor.execute(task, failures)
          reporter.postTask()
          tasksAndEvents += ((task.taskDef.fullyQualifiedName, events))
        }
        reporter.post(failures.toSeq)
        val xmlReporter = new JUnitXmlReporter(tasksAndEvents)
        xmlReporter.write
        !failures.nonEmpty
      }
    }
  }
}

class ClassLoaderTestRunner(framework: Framework, classLoaderProvider: () => ClassLoader, logger: Logger)
    extends TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) = {
    var tasksAndEvents = new mutable.ListBuffer[(String, mutable.ListBuffer[Event])]()
    val reporter = new TestReporter(logger)

    val classLoader = framework.getClass.getClassLoader
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
      }
    }

    val taskExecutor = new TestTaskExecutor(logger)
    val failures = mutable.Set[String]()
    tests.foreach { test =>
      val classLoader = classLoaderProvider()
      val isolatedFramework = new TestFrameworkLoader(classLoader, logger).load(framework.getClass.getName).get
      TestHelper.withRunner(isolatedFramework, scopeAndTestName, classLoader, arguments) { runner =>
        ClassLoaders.withContextClassLoader(classLoader) {
          val tasks = runner.tasks(Array(TestHelper.taskDef(test, scopeAndTestName)))
          tasks.foreach { task =>
            reporter.preTask(task)
            val events = taskExecutor.execute(task, failures)
            reporter.postTask()
            tasksAndEvents += ((task.taskDef.fullyQualifiedName, events))
          }
        }
      }
    }
    reporter.post(failures)
    val xmlReporter = new JUnitXmlReporter(tasksAndEvents)
    xmlReporter.write
    !failures.nonEmpty
  }
}

class ProcessCommand(
  val executable: String,
  val arguments: Seq[String]
) extends Serializable

class ProcessTestRunner(
  framework: Framework,
  classpath: Seq[Path],
  command: ProcessCommand,
  logger: Logger with Serializable
) extends TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]) = {
    val reporter = new TestReporter(logger)

    val classLoader = framework.getClass.getClassLoader
    ClassLoaders.withContextClassLoader(classLoader) {
      TestHelper.withRunner(framework, scopeAndTestName, classLoader, arguments) { runner =>
        val tasks = runner.tasks(tests.map(TestHelper.taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
      }
    }

    val taskExecutor = new TestTaskExecutor(logger)
    val failures = mutable.Set[String]()
    tests.foreach { test =>
      val process = new ProcessBuilder((command.executable +: command.arguments): _*)
        .redirectError(ProcessBuilder.Redirect.INHERIT)
        .redirectOutput(ProcessBuilder.Redirect.INHERIT)
        .start()
      try {
        val request = new TestRequest(
          framework.getClass.getName,
          test,
          scopeAndTestName,
          classpath.map(_.toString),
          logger,
          arguments
        )
        val out = new ObjectOutputStream(process.getOutputStream)
        try out.writeObject(request)
        finally out.close()
        if (process.waitFor() != 0) {
          failures += test.name
        }
      } finally process.destroy
    }
    reporter.post(failures.toSeq)
    !failures.nonEmpty
  }
}

trait TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String, arguments: Seq[String]): Boolean
}
