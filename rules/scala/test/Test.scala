package annex

import sbt.testing.{AnnotatedFingerprint, Fingerprint, Framework, Logger, Status, SubclassFingerprint, SuiteSelector, Task, TaskDef, TestWildcardSelector}
import scala.collection.{breakOut, mutable}
import scala.util.control.NonFatal
import xsbt.api.Discovery
import xsbti.api.{AnalyzedClass, ClassLike, Definition}

class TestDiscovery(subclassPrints: Iterable[SubclassFingerprint], annotatedPrints: Iterable[AnnotatedFingerprint]) {
  private[this] def definitions(classes: Set[AnalyzedClass]) = {
    classes.toSeq
      .flatMap(`class` => Seq(`class`.api.classApi, `class`.api.objectApi))
      .flatMap(api => Seq(api, api.structure.declared, api.structure.inherited))
      .collect { case cl: ClassLike if cl.topLevel => cl }
  }

  private[this] def discover(definitions: Seq[Definition]) =
    Discovery(subclassPrints.map(_.superclassName)(breakOut), annotatedPrints.map(_.annotationName)(breakOut))(
      definitions
    )

  def apply(classes: Set[AnalyzedClass]) =
    for {
      (definition, discovered) <- discover(definitions(classes))
      fingerprint <- subclassPrints.collect {
        case print if discovered.baseClasses(print.superclassName) && discovered.isModule == print.isModule => print
      } ++
        annotatedPrints.collect {
          case print if discovered.annotations(print.annotationName) && discovered.isModule == print.isModule => print
        }
    } yield new TestDefinition(definition.name, fingerprint)
}

class TestExecutor(loader: ClassLoader, logger: Logger, framework: Framework, taskDefs: Seq[TaskDef]) {}

class TestDefinition(val name: String, val fingerprint: Fingerprint)

class TestFramework(loader: ClassLoader, framework: Framework, logger: Logger) {
  def discover = {
    val subclassPrints = mutable.ArrayBuffer.empty[SubclassFingerprint]
    val annotatedPrints = mutable.ArrayBuffer.empty[AnnotatedFingerprint]
    framework.fingerprints.foreach {
      case fingerprint: SubclassFingerprint  => subclassPrints += fingerprint
      case fingerprint: AnnotatedFingerprint => annotatedPrints += fingerprint
    }
    new TestDiscovery(subclassPrints, annotatedPrints)
  }

  def execute(tests: Seq[TestDefinition], scopeAndTestName: String): Boolean = {
    val thread = Thread.currentThread
    val classLoader = thread.getContextClassLoader
    thread.setContextClassLoader(loader)
    try {
      val runner = framework.runner(
        Array.empty,
        if (framework.name == "specs2") Array("-ex", scopeAndTestName.replaceAll(".*::", "")) else Array.empty,
        loader
      )
      try {
        val taskDefs = tests.map(
          test =>
            new TaskDef(
              test.name,
              test.fingerprint,
              false,
              Array(new TestWildcardSelector(scopeAndTestName.replace("::", " ")))
          )
        )
        val tasks = runner.tasks(taskDefs.toArray)
        logger.info(s"${framework.getClass.getName}: ${tests.size} tests")
        logger.info("")
        val failures = mutable.Set[String]()
        def execute(task: Task): Unit = {
          val tasks = task.execute(
            event => {
              event.status match {
                case Status.Failure | Status.Error =>
                  failures += task.taskDef.fullyQualifiedName
                case _ =>
              }
            },
            Array(new PrefixedLogger(logger, "    ")),
          )
          tasks.foreach(execute)
        }
        tasks.foreach { task =>
          logger.info(task.taskDef.fullyQualifiedName)
          execute(task)
          logger.info("")
        }
        if (failures.nonEmpty) {
          logger.error(s"${failures.size} ${if (failures.size == 1) "failure" else "failures"}:")
          failures.toSeq.sorted.foreach(name => logger.error(s"    $name"))
          logger.error("")
          false
        } else {
          true
        }
      } finally {
        runner.done()
      }
    } finally {
      thread.setContextClassLoader(classLoader)
    }
  }
}

class TestFrameworkLoader(loader: ClassLoader, logger: Logger) {
  def load(className: String) = {
    val framework = try {
      Some(Class.forName(className, true, loader).getDeclaredConstructor().newInstance())
    } catch {
      case _: ClassNotFoundException => None
      case NonFatal(e)               => throw new Exception(s"Failed to load framework $className", e)
    }
    framework.map {
      case framework: Framework => new TestFramework(loader, framework, logger)
      case _                    => throw new Exception(s"$className does not implement ${classOf[Framework].getName}")
    }

  }
}

class PrefixedLogger(delegate: Logger, prefix: String) extends Logger {
  def ansiCodesSupported() = delegate.ansiCodesSupported()
  def error(msg: String) = delegate.error(prefix + msg)
  def warn(msg: String) = delegate.warn(prefix + msg)
  def info(msg: String) = delegate.info(prefix + msg)
  def debug(msg: String) = delegate.debug(prefix + msg)
  def trace(t: Throwable) = delegate.trace(t)
}
