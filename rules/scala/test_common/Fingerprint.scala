package annex

import sbt.testing.{AnnotatedFingerprint, SubclassFingerprint}

sealed trait TestFingerprint extends Serializable

class TestAnnotatedFingerprint(val annotationName: String, val isModule: Boolean)
    extends AnnotatedFingerprint
    with TestFingerprint

object TestAnnotatedFingerprint {
  def apply(fingerprint: AnnotatedFingerprint) =
    new TestAnnotatedFingerprint(fingerprint.annotationName, fingerprint.isModule)
}

class TestSubclassFingerprint(val isModule: Boolean, val requireNoArgConstructor: Boolean, val superclassName: String)
    extends SubclassFingerprint
    with TestFingerprint

object TestSubclassFingerprint {
  def apply(fingerprint: SubclassFingerprint) =
    new TestSubclassFingerprint(fingerprint.isModule, fingerprint.requireNoArgConstructor, fingerprint.superclassName)
}
