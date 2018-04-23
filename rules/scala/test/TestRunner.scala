package annex

import java.io.File
import java.net.URLClassLoader
import java.nio.file.attribute.FileTime
import java.nio.file.{FileAlreadyExistsException, Files, Paths}
import java.time.Instant
import java.util.regex.Pattern
import java.util.zip.GZIPInputStream
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.Argument
import sbt.internal.inc.binary.converters.ProtobufReaders
import sbt.internal.inc.schema
import sbt.testing.Logger
import scala.collection.JavaConverters._
import scala.util.control.NonFatal
import xsbti.compile.analysis.ReadMapper

object TestRunner {
  implicit class SetDefault(argument: Argument) {
    import scala.language.reflectiveCalls
    // https://issues.scala-lang.org/browse/SI-2991
    private[this] type SetDefault = { def setDefault(value: AnyRef) }
    def setDefault_[A](value: A) = argument.asInstanceOf[SetDefault].setDefault(value.asInstanceOf[AnyRef])
  }

  private[this] val argParser = {
    val parser = ArgumentParsers.newFor("test-runner").addHelp(true).fromFilePrefix("@").build()
    parser.description("Run tests")
    parser
      .addArgument("--color")
      .help("ANSI color")
      .metavar("class")
      .`type`(Arguments.booleanType)
      .setDefault_(true)
    parser
      .addArgument("--verbosity")
      .help("Verbosity")
      .choices("HIGH", "MEDIUM", "LOW")
      .setDefault_("MEDIUM")
    parser
  }

  private[this] val testArgParser = {
    val parser = ArgumentParsers.newFor("test").addHelp(true).build()
    parser
      .addArgument("--apis")
      .help("APIs file")
      .metavar("class")
      .`type`(Arguments.fileType.verifyCanRead().verifyExists())
      .required(true)
    parser
      .addArgument("--frameworks")
      .help("Class names of sbt.testing.Framework implementations")
      .metavar("class")
      .nargs("*")
      .required(true)
    parser
      .addArgument("classpath")
      .help("Testing classpath")
      .metavar("path")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead())
    parser
  }

  def main(args: Array[String]): Unit = {
    // for ((name, value) <- sys.env) println(name + "=" + value)
    val namespace = argParser.parseArgsOrFail(args)

    sys.env.get("TEST_SHARD_STATUS_FILE").map { path =>
      val file = Paths.get(path)
      try Files.createFile(file)
      catch {
        case _: FileAlreadyExistsException =>
          Files.setLastModifiedTime(file, FileTime.from(Instant.now))
      }
    }

    val runPath = Paths.get(sys.props("bazel.runPath"))

    val testArgFile = Paths.get(sys.props("scalaAnnex.test.args"))
    val testNamespace = testArgParser.parseArgsOrFail(Files.readAllLines(testArgFile).asScala.toArray)

    val logger = new AnxLogger(namespace.getBoolean("color"), namespace.getString("verbosity"))

    val classpath = testNamespace.getList[File]("classpath").asScala
    val classLoader =
      new URLClassLoader(classpath.map(file => runPath.resolve(file.toPath).toUri.toURL).toArray, null) {
        private[this] val shared = getClass.getClassLoader
        protected override def findClass(name: String) =
          if (name.startsWith("sbt.testing.")) shared.loadClass(name)
          else super.findClass(name)
      }

    val apisStream = Files.newInputStream(runPath.resolve(testNamespace.get[File]("apis").toPath))
    val apis = try {
      val raw = try schema.APIsFile.parseFrom(new GZIPInputStream(apisStream))
      finally apisStream.close()
      new ProtobufReaders(ReadMapper.getEmptyMapper).fromApisFile(raw)._1
    } catch {
      case NonFatal(e) => throw new Exception("Failed to load APIs", e)
    }

    val loader = new TestFrameworkLoader(classLoader, logger)
    val frameworks = testNamespace.getList[String]("frameworks").asScala.flatMap(loader.load)

    val testPattern = sys.env
      .get("TESTBRIDGE_TEST_ONLY")
      .map(text => Pattern.compile(raw"\Q${text.replace("*", raw"\E.*\Q")}\E"))

    var count = 0
    val passed = frameworks.forall { framework =>
      val tests = framework.discover(apis.internal.values.toSet).sortBy(_.name)
      val filter = for {
        index <- sys.env.get("TEST_SHARD_INDEX").map(_.toInt)
        total <- sys.env.get("TEST_TOTAL_SHARDS").map(_.toInt)
      } yield (test: TestDefinition, i: Int) => i % total == index
      val filteredTests = tests.filter { test =>
        testPattern.forall(_.matcher(test.name).matches) && {
          count += 1
          filter.fold(true)(_(test, count))
        }
      }
      filteredTests.isEmpty || framework.execute(filteredTests)
    }
    sys.exit(if (passed) 0 else 1)
  }
}

final class AnxLogger(color: Boolean, verbosity: String) extends Logger {
  def ansiCodesSupported = color

  def error(msg: String) = println(s"$msg")

  def warn(msg: String) = println(s"$msg")

  def info(msg: String) = verbosity match {
    case "HIGH" | "MEDIUM" => println(s"$msg")
    case _                 =>
  }

  def debug(msg: String) = verbosity match {
    case "HIGH" => println(s"$msg")
  }

  def trace(err: Throwable) = println(s"${err.getMessage}")
}
