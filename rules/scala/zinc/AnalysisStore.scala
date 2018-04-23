package annex.zinc

import com.google.devtools.build.buildjar.jarhelper.JarHelper
import com.trueaccord.lenses.{Lens, Mutation}
import com.trueaccord.scalapb.{GeneratedMessage, GeneratedMessageCompanion, Message}
import java.io._
import java.nio.charset.StandardCharsets
import java.nio.file._
import java.nio.file.attribute.{BasicFileAttributes, FileTime}
import java.util.Optional
import java.util.zip.{GZIPInputStream, GZIPOutputStream}
import sbt.internal.inc.binary.converters.{ProtobufReaders, ProtobufWriters}
import sbt.internal.inc.schema.{APIsFile, AnalysisFile}
import sbt.internal.inc.{Analysis, Stamper, schema, Stamp => StampImpl}
import sbt.io.IO
import xsbti.compile.analysis._
import xsbti.compile.{AnalysisContents, AnalysisStore, MiniSetup}

case class AnalysisFiles(analysis: Path, apis: Path)

object AnxAnalysisStore {
  trait Format {
    def read[A <: GeneratedMessage with Message[A]](message: GeneratedMessageCompanion[A], inputStream: InputStream): A
    def write(message: GeneratedMessage, stream: OutputStream)
  }
  object BinaryFormat extends Format {
    def read[A <: GeneratedMessage with Message[A]](companion: GeneratedMessageCompanion[A], stream: InputStream) =
      companion.parseFrom(new GZIPInputStream(stream))
    def write(message: GeneratedMessage, stream: OutputStream) = {
      val gzip = new GZIPOutputStream(stream, true)
      message.writeTo(gzip)
      gzip.finish()
    }
  }
  object TextFormat extends Format {
    def read[A <: GeneratedMessage with Message[A]](companion: GeneratedMessageCompanion[A], stream: InputStream) =
      companion.fromAscii(IO.readStream(stream, StandardCharsets.US_ASCII))
    def write(message: GeneratedMessage, stream: OutputStream) = {
      val writer = new OutputStreamWriter(stream, StandardCharsets.US_ASCII)
      try writer.write(message.toString)
      finally writer.close()
    }
  }
}

class AnxAnalysisStore(files: AnalysisFiles, format: AnxAnalysisStore.Format) extends AnalysisStore {
  private[this] val mappers = AnxMapper.mappers(Paths.get(""))
  private[this] val reader = new ProtobufReaders(mappers.getReadMapper)
  private[this] val writer = new ProtobufWriters(mappers.getWriteMapper)

  def get() =
    try {
      val analysisStream = Files.newInputStream(files.analysis)
      val analysisFile = (try format.read(schema.AnalysisFile, analysisStream)
      finally analysisStream.close()).update(analysisFileRead)
      val (analysis, miniSetup, _) = reader.fromAnalysisFile(analysisFile)
      val apisStream = Files.newInputStream(files.apis)
      val apisFile = (try format.read(schema.APIsFile, apisStream)
      finally apisStream.close()).update(apiFileRead)
      val (apis, _) = reader.fromApisFile(apisFile)
      Optional.of(AnalysisContents.create(analysis.copy(apis = apis), miniSetup))
    } catch {
      case _: NoSuchFileException => Optional.empty()
    }

  def set(analysisContents: AnalysisContents) = {
    val analysis = analysisContents.getAnalysis.asInstanceOf[Analysis]
    val analysisFile =
      writer.toAnalysisFile(analysis, analysisContents.getMiniSetup, schema.Version.V1).update(analysisFileWrite)
    val analysisStream = Files.newOutputStream(files.analysis)
    try format.write(analysisFile, analysisStream)
    finally analysisStream.close()
    val apis = analysis.apis
    val apisFile = writer.toApisFile(apis, schema.Version.V1).update(apiFileWrite)
    val apisStream = Files.newOutputStream(files.apis)
    try format.write(apisFile, apisStream)
    finally apisStream.close()
  }

  private[this] val analysisFileRead: Lens[AnalysisFile, AnalysisFile] => Mutation[AnalysisFile] =
    analysisFileMapper(mappers.getReadMapper)

  private[this] val analysisFileWrite: Lens[AnalysisFile, AnalysisFile] => Mutation[AnalysisFile] =
    _.update(
      analysisFileMapper(mappers.getWriteMapper),
      _.analysis.compilations.compilations.foreach(_.startTimeMillis := JarHelper.DEFAULT_TIMESTAMP)
    )

  private[this] val apiFileRead: Lens[APIsFile, APIsFile] => Mutation[APIsFile] = _ => identity

  private[this] val apiFileWrite: Lens[APIsFile, APIsFile] => Mutation[APIsFile] =
    _.apis.update(
      _.internal.foreachValue(_.compilationTimestamp := JarHelper.DEFAULT_TIMESTAMP),
      _.external.foreachValue(_.compilationTimestamp := JarHelper.DEFAULT_TIMESTAMP),
    )

  // Workaround for https://github.com/sbt/zinc/pull/532
  private[this] def analysisFileMapper(
    mapper: GenericMapper
  ): Lens[AnalysisFile, AnalysisFile] => Mutation[AnalysisFile] =
    _.analysis.relations.update(
      _.srcProd.foreach(_.modify {
        case (source, products) =>
          mapper.mapSourceFile(new File(source)).toString ->
            products.update(_.values.foreach(_.modify(path => mapper.mapProductFile(new File(path)).toString)))
      }),
      _.libraryDep.foreach(_.modify {
        case (source, binaries) =>
          mapper.mapSourceFile(new File(source)).toString ->
            binaries.update(_.values.foreach(_.modify(path => mapper.mapBinaryFile(new File(path)).toString)))
      }),
      _.libraryDep.foreach(_.modify {
        case (binary, values) => mapper.mapBinaryFile(new File(binary)).toString -> values
      }),
      _.classes.foreach(_.modify {
        case (source, values) => mapper.mapSourceFile(new File(source)).toString -> values
      }),
    )
}

object NormalizeTimeVisitor extends SimpleFileVisitor[Path] {
  override def visitFile(file: Path, attributes: BasicFileAttributes) = {
    Files.setLastModifiedTime(file, FileTime.fromMillis(JarHelper.DOS_EPOCH_IN_JAVA_TIME))
    super.visitFile(file, attributes)
  }
}

object AnxMapper {
  val rootPlaceholder = Paths.get("_ROOT_")
  def mappers(root: Path) = new ReadWriteMappers(new AnxReadMapper(root), new AnxWriteMapper(root))
}

final class AnxWriteMapper(root: Path) extends WriteMapper {
  private[this] val rootAbs = root.toAbsolutePath

  private[this] def mapFile(file: File) = {
    val path = file.toPath
    if (path.startsWith(rootAbs)) AnxMapper.rootPlaceholder.resolve(rootAbs.relativize(path)).toFile else file
  }

  def mapBinaryFile(binaryFile: File) = mapFile(binaryFile)
  def mapBinaryStamp(file: File, binaryStamp: Stamp) = Stamper.forHash(file)
  def mapClasspathEntry(classpathEntry: File) = mapFile(classpathEntry)
  def mapJavacOption(javacOption: String) = javacOption
  def mapMiniSetup(miniSetup: MiniSetup) = miniSetup
  def mapProductFile(productFile: File) = mapFile(productFile)
  def mapProductStamp(file: File, productStamp: Stamp) =
    StampImpl.fromString(s"lastModified(${JarHelper.DEFAULT_TIMESTAMP})")
  def mapScalacOption(scalacOption: String) = scalacOption
  def mapSourceDir(sourceDir: File) = mapFile(sourceDir)
  def mapSourceFile(sourceFile: File) = mapFile(sourceFile)
  def mapSourceStamp(file: File, sourceStamp: Stamp) = sourceStamp
  def mapOutputDir(outputDir: File) = mapFile(outputDir)
}

final class AnxReadMapper(root: Path) extends ReadMapper {
  private[this] val rootAbs = root.toAbsolutePath

  private[this] def mapFile(file: File) = {
    val path = file.toPath
    if (path.startsWith(AnxMapper.rootPlaceholder)) rootAbs.resolve(AnxMapper.rootPlaceholder.relativize(path)).toFile
    else file
  }

  def mapBinaryFile(file: File) = mapFile(file)
  def mapBinaryStamp(file: File, stamp: Stamp) =
    if (Stamper.forHash(file) == stamp) Stamper.forLastModified(file) else stamp
  def mapClasspathEntry(classpathEntry: File) = mapFile(classpathEntry)
  def mapJavacOption(javacOption: String) = javacOption
  def mapOutputDir(dir: File) = mapFile(dir)
  def mapMiniSetup(miniSetup: MiniSetup) = miniSetup
  def mapProductFile(file: File) = mapFile(file)
  def mapProductStamp(file: File, productStamp: Stamp) = Stamper.forLastModified(file)
  def mapScalacOption(scalacOption: String) = scalacOption
  def mapSourceDir(sourceDir: File) = mapFile(sourceDir)
  def mapSourceFile(sourceFile: File) = mapFile(sourceFile)
  def mapSourceStamp(file: File, sourceStamp: Stamp) = sourceStamp
}
