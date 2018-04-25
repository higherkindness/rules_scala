package anx

import java.nio.file.{Files, Paths}
import java.util.zip.GZIPInputStream
import sbt.internal.inc.schema.AnalysisFile
import sbt.internal.inc.binary.converters.ProtobufReaders
import xsbti.compile.analysis.ReadMapper
import xsbti.compile.FileAnalysisStore

object Tool {
  def main(args: Array[String]): Unit =
    args.toList match {
      case path :: Nil =>
        process(path)
      case other =>
        println(s"bad arguments: $other")
        System.exit(-1)
    }

  private def process(path: String): Unit = {
    val stream = Files.newInputStream(Paths.get(path))
    val analysisFile = AnalysisFile.parseFrom(new GZIPInputStream(stream))
    stream.close()
    val readMapper = ReadMapper.getMachineIndependentMapper(Paths.get("."))
    val reader = new ProtobufReaders(readMapper)
    //val analysis = reader.fromAnalysisFile(analysisFile)
    //print(analysis)
    print(analysisFile)
  }
}
