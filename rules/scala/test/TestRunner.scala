package annex

import annex.args.Implicits._
import java.io.File
import java.net.URLClassLoader
import java.nio.file.attribute.FileTime
import java.nio.file.{FileAlreadyExistsException, Files, Paths}
import java.time.Instant
import java.util.Collections
import java.util.regex.Pattern
import java.util.zip.GZIPInputStream
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.Argument
import org.scalatools.testing.Framework
import sbt.internal.inc.binary.converters.ProtobufReaders
import sbt.internal.inc.classpath.LoaderBase
import sbt.internal.inc.schema
import sbt.testing.Logger
import scala.collection.JavaConverters._
import scala.util.control.NonFatal
import xsbti.compile.analysis.ReadMapper

object TestRunner {

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
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("classpath")
      .help("Testing classpath")
      .metavar("path")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead().verifyExists())
      .setDefault_(Collections.emptyList)
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

    val urls =
      testNamespace
        .getList[File]("classpath")
        .asScala
        .map(file => runPath.resolve(file.toPath).toUri.toURL)

    val classLoader = new URLClassLoader(urls.toArray, null) {
      private[this] val current = getClass.getClassLoader()
      override protected def findClass(className: String): Class[_] =
        if (className.startsWith("sbt.testing.")) current.loadClass(className) else super.findClass(className)
    }

    val apisFile = runPath.resolve(testNamespace.get[File]("apis").toPath)
    val apisStream = Files.newInputStream(apisFile)
    val apis = try {
      val raw = try schema.APIs.parseFrom(new GZIPInputStream(apisStream))
      finally apisStream.close()
      new ProtobufReaders(ReadMapper.getEmptyMapper).fromApis(raw)
    } catch {
      case NonFatal(e) => throw new Exception(s"Failed to load APIs from $apisFile", e)
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
