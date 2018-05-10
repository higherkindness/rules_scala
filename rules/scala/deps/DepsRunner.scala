package annex.deps

import annex.worker.SimpleMain
import java.io.File
import java.nio.file.{FileAlreadyExistsException, Files}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import scala.collection.JavaConverters._

object DepsRunner extends SimpleMain {
  private[this] val argParser = {
    val parser = ArgumentParsers.newFor("deps").addHelp(true).fromFilePrefix("@").build
    parser.addArgument("--check_direct").`type`(Arguments.booleanType)
    parser.addArgument("--check_used").`type`(Arguments.booleanType)
    parser.addArgument("--direct").help("Labels of direct deps").metavar("label").nargs("*")
    parser
      .addArgument("--group")
      .action(Arguments.append)
      .help("Label and manifest of jars")
      .metavar("label[|path|path...]")
    parser.addArgument("--label").help("Label of current target").metavar("label").required(true)
    parser.addArgument("--whitelist").help("Whitelist of labels to ignore for unused deps").metavar("label").nargs("*")
    parser.addArgument("used").help("Manifest of used").`type`(Arguments.fileType.verifyCanRead().verifyIsFile())
    parser.addArgument("success").help("Success file").`type`(Arguments.fileType.verifyCanCreate())
    parser
  }

  protected[this] def work(args: Array[String]) = {
    val namespace = argParser.parseArgs(args)

    val label = namespace.getString("label").tail
    val directLabels = namespace.getList[String]("direct").asScala.map(_.tail)
    val groups = Option(namespace.getList[String]("group"))
      .fold[Seq[String]](Nil)(_.asScala)
      .map(_.split('|').toSeq)
      .map { case label +: jars => label.tail -> jars.toSet }
    val labelToPaths = groups.toMap
    val usedPaths = Files.readAllLines(namespace.get[File]("used").toPath).asScala.toSet

    val remove = if (namespace.getBoolean("check_used") == true) {
      val whitelist = namespace.getList[String]("whitelist").asScala.map(_.tail)
      (directLabels -- whitelist).filterNot(labelToPaths(_).exists(usedPaths))
    } else Nil
    remove.foreach { depLabel =>
      println(s"Target '$depLabel' not used, please remove it from the deps.")
      println(s"You can use the following buildozer command:")
      println(s"buildozer 'remove deps $depLabel' $label")
    }

    val add = if (namespace.getBoolean("check_direct") == true) {
      (usedPaths -- directLabels.flatMap(labelToPaths))
        .flatMap(
          path =>
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

    if (add.nonEmpty || remove.nonEmpty) {
      sys.exit(1)
    }

    try Files.createFile(namespace.get[File]("success").toPath)
    catch { case _: FileAlreadyExistsException => }
  }
}
