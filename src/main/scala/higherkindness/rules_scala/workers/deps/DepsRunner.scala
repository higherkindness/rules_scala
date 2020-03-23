package higherkindness.rules_scala
package workers.deps

import common.args.implicits._
import common.worker.WorkerMain

import java.io.File
import java.nio.file.{FileAlreadyExistsException, Files}
import java.util.Collections
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import scala.collection.JavaConverters._

object DepsRunner extends WorkerMain[Unit] {
  private[this] val argParser = {
    val parser = ArgumentParsers.newFor("deps").addHelp(true).fromFilePrefix("@").build
    parser.addArgument("--check_direct").`type`(Arguments.booleanType)
    parser.addArgument("--check_used").`type`(Arguments.booleanType)
    parser
      .addArgument("--direct")
      .help("Labels of direct deps")
      .metavar("label")
      .nargs("*")
      .setDefault_(Collections.emptyList())
    parser
      .addArgument("--group")
      .action(Arguments.append)
      .help("Label and manifest of jars")
      .metavar("label [path [path ...]]")
      .nargs("+")
    parser.addArgument("--label").help("Label of current target").metavar("label").required(true)
    parser
      .addArgument("--used_whitelist")
      .help("Whitelist of labels to ignore for unused deps")
      .metavar("label")
      .nargs("*")
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--unused_whitelist")
      .help("Whitelist of labels to ignore for direct deps")
      .metavar("label")
      .nargs("*")
      .setDefault_(Collections.emptyList)
    parser.addArgument("used").help("Manifest of used").`type`(Arguments.fileType.verifyCanRead().verifyIsFile())
    parser.addArgument("success").help("Success file").`type`(Arguments.fileType.verifyCanCreate())
    parser
  }

  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit = {
    val namespace = argParser.parseArgs(args)

    val label = namespace.getString("label").tail
    val directLabels = namespace.getList[String]("direct").asScala.map(_.tail)
    val groups = Option(namespace.getList[java.util.List[String]]("group"))
      .fold[Seq[List[String]]](Nil)(_.asScala.toSeq.map(_.asScala.toList))
      .map { case label +: jars => label.tail -> jars.toSet }
    val labelToPaths = groups.toMap
    val usedPaths = Files.readAllLines(namespace.get[File]("used").toPath).asScala.toSet

    val remove = if (namespace.getBoolean("check_used") == true) {
      val usedWhitelist = namespace.getList[String]("used_whitelist").asScala.map(_.tail)
      (directLabels -- usedWhitelist).filterNot(labelToPaths(_).exists(usedPaths))
    } else Nil
    remove.foreach { depLabel =>
      println(s"Target '$depLabel' not used, please remove it from the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'remove deps $depLabel' $label")
    }

    val add = if (namespace.getBoolean("check_direct") == true) {
      val unusedWhitelist = namespace.getList[String]("unused_whitelist").asScala.map(_.tail)
      (usedPaths -- (directLabels ++ unusedWhitelist).flatMap(labelToPaths))
        .flatMap(path =>
          groups.collectFirst { case (label, paths) if paths(path) => label }.orElse {
            System.err.println(s"Warning: There is a reference to $path, but no dependency of $label provides it")
            None
          }
        )
    } else Nil
    add.foreach { depLabel =>
      println(s"Target '$depLabel' is used but isn't explicitly declared, please add it to the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'add deps $depLabel' $label")
    }

    if (add.isEmpty && remove.isEmpty) {
      try Files.createFile(namespace.get[File]("success").toPath)
      catch { case _: FileAlreadyExistsException => }
    }

  }
}
