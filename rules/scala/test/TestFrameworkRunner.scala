package annex

import sbt.testing.{Framework, Logger, Runner, Task, TaskDef, TestWildcardSelector}
import scala.collection.mutable

trait TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String): Boolean

  protected[this] def withRunner[A](framework: Framework, scopeAndTestName: String, classLoader: ClassLoader)(
    f: Runner => A
  ) = {
    val options =
      if (framework.name == "specs2") Array("-ex", scopeAndTestName.replaceAll(".*::", "")) else Array.empty[String]
    val runner = framework.runner(Array.empty, options, classLoader)
    try f(runner)
    finally runner.done()
  }

  protected[this] def taskDef(test: TestDefinition, scopeAndTestName: String) =
    new TaskDef(
      test.name,
      test.fingerprint,
      false,
      Array(new TestWildcardSelector(scopeAndTestName.replace("::", " ")))
    )
}

class BasicTestRunner(framework: Framework, classLoader: ClassLoader, logger: Logger) extends TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String) =
    ClassLoader.withContextClassLoader(classLoader) {
      withRunner(framework, scopeAndTestName, classLoader) { runner =>
        val reporter = new TestReporter(logger)
        val tasks = runner.tasks(tests.map(taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
        val taskExecutor = new TestTaskExecutor(logger)
        val failures = mutable.Set[String]()
        tasks.foreach { task =>
          reporter.preTask(task)
          taskExecutor.execute(task, failures)
          reporter.postTask()
        }
        reporter.post(failures.toSeq)
        !failures.nonEmpty
      }
    }
}

class ClassLoaderTestRunner(framework: Framework, classLoaderProvider: () => ClassLoader, logger: Logger)
    extends TestFrameworkRunner {
  def execute(tests: Seq[TestDefinition], scopeAndTestName: String) = {
    val reporter = new TestReporter(logger)

    val classLoader = framework.getClass.getClassLoader
    ClassLoader.withContextClassLoader(classLoader) {
      withRunner(framework, scopeAndTestName, classLoader) { runner =>
        val tasks = runner.tasks(tests.map(taskDef(_, scopeAndTestName)).toArray)
        reporter.pre(framework, tasks)
      }
    }

    val taskExecutor = new TestTaskExecutor(logger)
    val failures = mutable.Set[String]()
    tests.foreach { test =>
      val classLoader = classLoaderProvider()
      val isolatedFramework = new TestFrameworkLoader(classLoader, logger).load(framework.getClass.getName).get
      withRunner(isolatedFramework, scopeAndTestName, classLoader) { runner =>
        ClassLoader.withContextClassLoader(classLoader) {
          val tasks = runner.tasks(Array(taskDef(test, scopeAndTestName)))
          tasks.foreach { task =>
            reporter.preTask(task)
            taskExecutor.execute(task, failures)
            reporter.postTask()
          }
        }
      }
    }
    reporter.post(failures)
    !failures.nonEmpty
  }
}
