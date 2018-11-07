package annex

import sbt.testing.{AnnotatedFingerprint, Fingerprint, Framework, SubclassFingerprint, SuiteSelector}
import scala.collection.{breakOut, mutable}
import xsbt.api.Discovery
import xsbti.api.{AnalyzedClass, ClassLike, Definition}

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
