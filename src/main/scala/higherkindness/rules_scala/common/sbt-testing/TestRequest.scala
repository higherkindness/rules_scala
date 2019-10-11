package higherkindness.rules_scala
package common.sbt_testing

import sbt.testing.Logger

class TestRequest(
  val framework: String,
  val test: TestDefinition,
  val scopeAndTestName: String,
  val classpath: Seq[String],
  val logger: Logger with Serializable,
  val testArgs: Seq[String]
) extends Serializable
