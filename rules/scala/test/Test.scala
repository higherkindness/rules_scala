package annex

import sbt.testing.{AnnotatedFingerprint, Fingerprint, Framework, Logger, Status, SubclassFingerprint, SuiteSelector, Task, TaskDef}
import scala.collection.{breakOut, mutable}
import scala.util.control.NonFatal
import xsbt.api.Discovery
import xsbti.api.{AnalyzedClass, ClassLike, Definition}

class ProcessCommand(
  val executable: String,
  val arguments: Seq[String]
) extends Serializable

class TestDiscovery(framework: Framework) {
  private[this] val (annotatedPrints, subclassPrints) = {
    val annotatedPrints = mutable.ArrayBuffer.empty[TestAnnotatedFingerprint]
    val subclassPrints = mutable.ArrayBuffer.empty[TestSubclassFingerprint]
    framework.fingerprints.foreach {
      case fingerprint: AnnotatedFingerprint => annotatedPrints += TestAnnotatedFingerprint(fingerprint)
      case fingerprint: SubclassFingerprint  => subclassPrints += TestSubclassFingerprint(fingerprint)
    }
    (annotatedPrints.toSet, subclassPrints.toSet)
  }

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

class TestDefinition(val name: String, val fingerprint: Fingerprint with Serializable) extends Serializable

class TestTaskExecutor(logger: Logger) {
  def execute(task: Task, failures: mutable.Set[String]) = {
    def execute(task: Task): Unit = {
      val tasks = task.execute(
        event =>
          event.status match {
            case Status.Failure | Status.Error =>
              failures += task.taskDef.fullyQualifiedName
            case _ =>
        },
        Array(new PrefixedLogger(logger, "    ")),
      )
      tasks.foreach(execute)
    }
    execute(task)
  }
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

class TestFrameworkLoader(loader: ClassLoader, logger: Logger) {
  def load(className: String) = {
    val framework = try {
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

class PrefixedLogger(delegate: Logger, prefix: String) extends Logger {
  def ansiCodesSupported() = delegate.ansiCodesSupported()
  def error(msg: String) = delegate.error(prefix + msg)
  def warn(msg: String) = delegate.warn(prefix + msg)
  def info(msg: String) = delegate.info(prefix + msg)
  def debug(msg: String) = delegate.debug(prefix + msg)
  def trace(t: Throwable) = delegate.trace(t)
}
