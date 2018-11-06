package annex

import sbt.testing.Logger

class TestRequest(
  val framework: String,
  val test: TestDefinition,
  val scopeAndTestName: String,
  val classpath: Seq[String],
  val logger: Logger with Serializable
) extends Serializable
