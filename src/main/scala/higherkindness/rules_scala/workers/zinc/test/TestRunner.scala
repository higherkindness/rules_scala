package higherkindness.rules_scala
package workers.zinc.test

import common.args.implicits._
import common.sbt_testing.AnnexTestingLogger
import common.sbt_testing.ClassLoaders
import common.sbt_testing.TestDefinition
import common.sbt_testing.TestFrameworkLoader
import common.sbt_testing.TestRequest

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
import org.scalatools.testing.Framework
import sbt.internal.inc.binary.converters.ProtobufReaders
import sbt.internal.inc.schema
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
      .addArgument("--subprocess_arg")
      .action(Arguments.append)
      .help("Argument for tests run in new JVM process")
    parser
      .addArgument("--verbosity")
      .help("Verbosity")
      .choices("HIGH", "MEDIUM", "LOW")
      .setDefault_("MEDIUM")
    parser
      .addArgument("--framework_args")
      .help("Additional arguments for testing framework")
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
      .addArgument("--subprocess_exec")
      .help("Executable for SubprocessTestRunner")
      .`type`(Arguments.fileType)
    parser
      .addArgument("--isolation")
      .choices("classloader", "none", "process")
      .help("Test isolation")
      .setDefault_("none")
    parser
      .addArgument("--frameworks")
      .help("Class names of sbt.testing.Framework implementations")
      .metavar("class")
      .nargs("*")
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--shared_classpath")
      .help("Classpath to share between tests")
      .metavar("path")
      .nargs("*")
      .`type`(Arguments.fileType)
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

    val logger = new AnnexTestingLogger(namespace.getBoolean("color"), namespace.getString("verbosity"))

    val classpath = testNamespace
      .getList[File]("classpath")
      .asScala
      .map(file => runPath.resolve(file.toPath))
    val sharedClasspath = testNamespace
      .getList[File]("shared_classpath")
      .asScala
      .map(file => runPath.resolve(file.toPath))

    val sharedUrls = classpath.filter(sharedClasspath.toSet).map(_.toUri.toURL)

    val classLoader = ClassLoaders.sbtTestClassLoader(classpath.map(_.toUri.toURL))
    val sharedClassLoader = ClassLoaders.sbtTestClassLoader(classpath.filter(sharedClasspath.toSet).map(_.toUri.toURL))

    val apisFile = runPath.resolve(testNamespace.get[File]("apis").toPath)
    val apisStream = Files.newInputStream(apisFile)
    val apis =
      try {
        val raw =
          try schema.APIs.parseFrom(new GZIPInputStream(apisStream))
          finally apisStream.close()
        new ProtobufReaders(ReadMapper.getEmptyMapper, schema.Version.V1).fromApis(shouldStoreApis = true)(raw)
      } catch {
        case NonFatal(e) => throw new Exception(s"Failed to load APIs from $apisFile", e)
      }

    val loader = new TestFrameworkLoader(classLoader, logger)
    val frameworks = testNamespace.getList[String]("frameworks").asScala.flatMap(loader.load)

    val testClass = sys.env
      .get("TESTBRIDGE_TEST_ONLY")
      .map(text => Pattern.compile(if (text contains "#") raw"${text.replaceAll("#.*", "")}" else text))
    val testScopeAndName = sys.env
      .get("TESTBRIDGE_TEST_ONLY")
      .map(text =>
        if (text contains "#") text.replaceAll(".*#", "").replaceAll("\\$", "").replace("\\Q", "").replace("\\E", "")
        else ""
      )

    var count = 0
    val passed = frameworks.forall { framework =>
      val tests = new TestDiscovery(framework)(apis.internal.values.toSet).sortBy(_.name)
      val filter = for {
        index <- sys.env.get("TEST_SHARD_INDEX").map(_.toInt)
        total <- sys.env.get("TEST_TOTAL_SHARDS").map(_.toInt)
      } yield (test: TestDefinition, i: Int) => i % total == index
      val filteredTests = tests.filter { test =>
        testClass.forall(_.matcher(test.name).matches) && {
          count += 1
          filter.fold(true)(_(test, count))
        }
      }
      filteredTests.isEmpty || {
        val runner = testNamespace.getString("isolation") match {
          case "classloader" =>
            val urls = classpath.filterNot(sharedClasspath.toSet).map(_.toUri.toURL).toArray
            def classLoaderProvider() = new URLClassLoader(urls, sharedClassLoader)
            new ClassLoaderTestRunner(framework, classLoaderProvider, logger)
          case "process" =>
            val executable = runPath.resolve(testNamespace.get[File]("subprocess_exec").toPath)
            val arguments = Option(namespace.getList[String]("subprocess_arg")).fold[Seq[String]](Nil)(_.asScala)
            new ProcessTestRunner(framework, classpath, new ProcessCommand(executable.toString, arguments), logger)
          case "none" => new BasicTestRunner(framework, classLoader, logger)
        }
        val testFrameworkArguments =
          Option(namespace.getString("framework_args")).map(_.split("\\s+").toList).getOrElse(Seq.empty[String])
        try runner.execute(filteredTests, testScopeAndName.getOrElse(""), testFrameworkArguments)
        catch {
          case e: Throwable =>
            e.printStackTrace()
            false
        }
      }
    }
    sys.exit(if (passed) 0 else 1)
  }
}
