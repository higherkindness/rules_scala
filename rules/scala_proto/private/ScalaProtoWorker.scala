package annex.scala.proto

import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.inf.ArgumentParser
import net.sourceforge.argparse4j.impl.Arguments

import protocbridge.ProtocBridge
import scalapb.ScalaPbCodeGenerator

import scala.collection.JavaConverters._
import java.io.File
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.util.Collections

import com.google.devtools.build.buildjar.jarhelper.JarCreator
import annex.args.Implicits._
import annex.worker.SimpleMain

object ScalaProtoWorker extends SimpleMain {

  private[this] val argParser: ArgumentParser = {
    val parser = ArgumentParsers.newFor("proto").addHelp(true).fromFilePrefix("@").build
    parser
      .addArgument("--output_srcjar")
      .help("Output srcjar")
      .metavar("output_srcjar")
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

  protected[this] def work(args: Array[String]) = {
    val namespace = argParser.parseArgs(args)
    val sources: List[File] = namespace.getList[File]("sources").asScala.toList

    val scalaOut: Path = Paths.get("tmp", "src")
    Files.createDirectories(scalaOut)

    val params: List[String] =
      s"--scala_out=$scalaOut" ::
      sources.map(_.getPath)

    ProtocBridge.runWithGenerators(
      protoc = a => com.github.os72.protocjar.Protoc.runProtoc(a.toArray),
      namedGenerators = List("scala" -> ScalaPbCodeGenerator),
      params = params)

    val jarCreator = new JarCreator(namespace.get[File]("output_srcjar").toPath)
    jarCreator.addDirectory(scalaOut)
    jarCreator.setCompression(true)
    jarCreator.setNormalize(true)
    jarCreator.setVerbose(false)
    jarCreator.execute()
  }

}
