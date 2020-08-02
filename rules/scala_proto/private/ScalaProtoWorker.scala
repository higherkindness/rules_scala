package annex.scala.proto

import higherkindness.rules_scala.common.args.implicits._
import higherkindness.rules_scala.common.worker.WorkerMain
import java.io.File
import java.nio.file.{Files, Paths}
import java.util.Collections
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.ArgumentParser
import protocbridge.ProtocBridge
import scala.collection.JavaConverters._
import scalapb.ScalaPbCodeGenerator

object ScalaProtoWorker extends WorkerMain[Unit] {

  private[this] val argParser: ArgumentParser = {
    val parser = ArgumentParsers.newFor("proto").addHelp(true).fromFilePrefix("@").build
    parser
      .addArgument("--proto_path")
      .help("Proto path")
      .metavar("proto_path")
      .nargs("*")
      .`type`(Arguments.fileType.verifyIsDirectory)
      .setDefault_(Collections.emptyList)
    parser
      .addArgument("--output_dir")
      .help("Output dir")
      .metavar("output_dir")
      .`type`(Arguments.fileType.verifyCanCreate)
    parser
      .addArgument("sources")
      .help("Source files")
      .metavar("source")
      .nargs("*")
      .`type`(Arguments.fileType.verifyCanRead.verifyIsFile)
      .setDefault_(Collections.emptyList)
    parser
  }

  override def init(args: Option[Array[String]]): Unit = ()

  protected[this] def work(ctx: Unit, args: Array[String]): Unit = {
    val namespace = argParser.parseArgs(args)
    val sources = namespace.getList[File]("sources").asScala.toList
    val path = namespace.getList[File]("proto_path").asScala.toList

    val scalaOut = namespace.get[File]("output_dir").toPath
    Files.createDirectories(scalaOut)

    val params = s"--scala_out=$scalaOut" :: path.map("--proto_path " ++ _.getPath) ++ sources.map(_.getPath)

    ProtocBridge.runWithGenerators(
      protoc = a => com.github.os72.protocjar.Protoc.runProtoc(a.toArray),
      namedGenerators = List("scala" -> ScalaPbCodeGenerator),
      params = params)
  }

}
