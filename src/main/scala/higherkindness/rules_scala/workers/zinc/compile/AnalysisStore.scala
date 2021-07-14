package higherkindness.rules_scala
package workers.zinc.compile

import com.google.devtools.build.buildjar.jarhelper.JarHelper
import java.io.{File, InputStream, OutputStream, OutputStreamWriter}
import java.nio.charset.StandardCharsets
import java.nio.file.{Files, NoSuchFileException, Path, Paths}
import java.nio.file.attribute.FileTime
import java.util.zip.{GZIPInputStream, GZIPOutputStream}
import java.util.Optional
import sbt.internal.inc.binary.converters.{ProtobufReaders, ProtobufWriters}
import sbt.internal.inc.Schema.Type.{Projection, Structure}
import sbt.internal.inc.{APIs, Analysis, PlainVirtualFile, PlainVirtualFileConverter, Relations, Schema, SourceInfos, Stamp => StampImpl, Stamper, Stamps}
import sbt.internal.inc.Schema.{AnalyzedClass, Annotation, ClassDependencies, ClassLike, Companions, NameHash, Type, TypeParameter, UsedName, UsedNames, Values}
import sbt.internal.shaded.com.google.protobuf.{GeneratedMessage, GeneratedMessageV3, Message}
import sbt.io.IO
import scala.math.Ordering
import scala.collection.mutable.StringBuilder
import scala.collection.immutable.TreeMap
import xsbti.compile.analysis.{GenericMapper, ReadMapper, ReadWriteMappers, Stamp, WriteMapper}
import xsbti.compile.{AnalysisContents, AnalysisStore, MiniSetup}
import scala.collection.JavaConverters._
import xsbti.VirtualFileRef

case class AnalysisFiles(apis: Path, miniSetup: Path, relations: Path, sourceInfos: Path, stamps: Path)

object AnxAnalysisStore {
  trait Format {
    def read[A <: GeneratedMessageV3](message: A, inputStream: InputStream): A
    def write(message: GeneratedMessageV3, stream: OutputStream): Unit
  }
  object BinaryFormat extends Format {
    def read[A <: GeneratedMessageV3](message: A, stream: InputStream): A = {
      message.getParserForType.parseFrom(new GZIPInputStream(stream)).asInstanceOf[A]
    }

    def write(message: GeneratedMessageV3, stream: OutputStream): Unit = {
      val gzip = new GZIPOutputStream(stream, true)
      message.writeTo(gzip)
      gzip.finish()
    }
  }
  object TextFormat extends Format {
    def read[A <: GeneratedMessageV3](message: A, stream: InputStream): A = {
      val builder = message.toBuilder()
      sbt.internal.shaded.com.google.protobuf.TextFormat.merge(
        IO.readStream(stream, StandardCharsets.US_ASCII),
        builder
      )
      builder.build().asInstanceOf[A]
    }

    def write(message: GeneratedMessageV3, stream: OutputStream): Unit = {
      val printer = sbt.internal.shaded.com.google.protobuf.TextFormat.printer()
      val writer = new OutputStreamWriter(stream, StandardCharsets.US_ASCII)
      try printer.escapingNonAscii(true).print(message, writer)
      finally writer.close()
    }
  }
}

trait Readable[A] {
  def read(file: Path): A
}

trait Writeable[A] {
  def write(file: Path, value: A): Unit
}

class Store[A](readStream: InputStream => A, writeStream: (OutputStream, A) => Unit)
    extends Readable[A]
    with Writeable[A] {
  def read(file: Path): A = {
    val stream = Files.newInputStream(file)
    try {
      readStream(stream)
    } finally {
      stream.close()
    }
  }
  def write(file: Path, value: A): Unit = {
    val stream = Files.newOutputStream(file)
    try {
      writeStream(stream, value)
    } finally {
      stream.close()
    }
  }
}

class AnxAnalysisStore(files: AnalysisFiles, analyses: AnxAnalyses) extends AnalysisStore {
  def get(): Optional[AnalysisContents] = {
    try {
      val analysis = Analysis.Empty.copy(
        apis = analyses.apis().read(files.apis),
        relations = analyses.relations.read(files.relations),
        infos = analyses.sourceInfos.read(files.sourceInfos),
        stamps = analyses.stamps.read(files.stamps)
      )
      val miniSetup = analyses.miniSetup.read(files.miniSetup)
      Optional.of(AnalysisContents.create(analysis, miniSetup))
    } catch {
      case e: NoSuchFileException => Optional.empty()
    }
  }

  override def unsafeGet(): AnalysisContents = {
    get().get()
  }

  def set(analysisContents: AnalysisContents) = {
    val analysis = analysisContents.getAnalysis.asInstanceOf[Analysis]
    analyses.apis().write(files.apis, analysis.apis)
    analyses.relations.write(files.relations, analysis.relations)
    analyses.sourceInfos.write(files.sourceInfos, analysis.infos)
    analyses.stamps.write(files.stamps, analysis.stamps)
    val miniSetup = analysisContents.getMiniSetup
    analyses.miniSetup.write(files.miniSetup, miniSetup)
  }

}

class AnxAnalyses(format: AnxAnalysisStore.Format) {
  private[this] val mappers = AnxMapper.mappers(Paths.get(""))
  private[this] val reader = new ProtobufReaders(mappers.getReadMapper, Schema.Version.V1_1)
  private[this] val writer = new ProtobufWriters(mappers.getWriteMapper)

  def sortProjection(value: Projection): Projection = {
    // I copied this over from the old code, but I'm pretty sure this isn't doing anything useful?
    Projection
      .newBuilder(value)
      .setId(value.getId)
      .setPrefix(value.getPrefix)
      .build()
  }

  // This should be done sometime
  // But I can't figure out how to sort a Type differently based on which subclass it's a member of
  def sortType[A <: Type](value: A): Type = {
    value
  }

  def sortAnnotation(annotation: Annotation): Annotation = {
    val sortedArguments = annotation.getArgumentsList.asScala.sortWith(_.hashCode() > _.hashCode()).asJava
    Annotation
      .newBuilder(annotation)
      .clearArguments()
      .addAllArguments(sortedArguments)
      .build()
  }

  def sortTypeParameter(typeParameter: TypeParameter): TypeParameter = {
    val sortedAnnotations =
      typeParameter.getAnnotationsList.asScala.map(sortAnnotation).sortWith(_.hashCode() > _.hashCode()).asJava
    val sortedTypeParameters = sortTypeParameters(typeParameter.getTypeParametersList.asScala.toSeq).asJava

    TypeParameter
      .newBuilder(typeParameter)
      .clearAnnotations()
      .addAllAnnotations(sortedAnnotations)
      .clearTypeParameters()
      .addAllTypeParameters(sortedTypeParameters)
      .build()
  }

  def sortStructure(structure: Structure): Structure = {
    val sortedParents = structure.getParentsList.asScala.sortWith(_.hashCode() < _.hashCode()).asJava
    val sortedDeclared = structure.getDeclaredList.asScala.sortWith(_.hashCode() < _.hashCode()).asJava
    val sortedInherited = structure.getInheritedList.asScala.sortWith(_.hashCode() < _.hashCode()).asJava

    Structure
      .newBuilder(structure)
      .clearParents()
      .addAllParents(sortedParents)
      .clearDeclared()
      .addAllDeclared(sortedDeclared)
      .clearInherited()
      .addAllInherited(sortedInherited)
      .build()
  }

  def sortTypeParameters(typeParameters: Seq[TypeParameter]): Seq[TypeParameter] = {
    typeParameters.map(sortTypeParameter).sortWith(_.hashCode() > _.hashCode())
  }

  def sortClassLike(classLike: ClassLike): ClassLike = {
    val sortedAnnotations =
      classLike.getAnnotationsList.asScala.map(sortAnnotation).sortWith(_.hashCode() > _.hashCode()).asJava
    val sortedStructure = sortStructure(classLike.getStructure)
    val sortedSavedAnnotations = classLike.getSavedAnnotationsList.asScala.sorted.asJava
    val sortedChildrenOfSealedClass =
      classLike.getChildrenOfSealedClassList.asScala.map(sortType).sortWith(_.hashCode() > _.hashCode()).asJava
    val sortedTypeParameters = sortTypeParameters(classLike.getTypeParametersList.asScala.toSeq).asJava
    ClassLike
      .newBuilder(classLike)
      .clearAnnotations()
      .addAllAnnotations(sortedAnnotations)
      .clearStructure()
      .setStructure(sortedStructure)
      .clearSavedAnnotations()
      .addAllSavedAnnotations(sortedSavedAnnotations)
      .clearChildrenOfSealedClass()
      .addAllChildrenOfSealedClass(sortedChildrenOfSealedClass)
      .clearTypeParameters()
      .addAllTypeParameters(sortedTypeParameters)
      .build()
  }

  def sortCompanions(companions: Companions): Companions = {
    val sortedClassApi = sortClassLike(companions.getClassApi)
    val sortedObjectApi = sortClassLike(companions.getObjectApi)

    Companions
      .newBuilder(companions)
      .clearClassApi()
      .setClassApi(sortedClassApi)
      .clearObjectApi()
      .setObjectApi(sortedObjectApi)
      .build()
  }

  def sortAnalyzedClassMap(analyzedClassMap: Map[String, AnalyzedClass]): TreeMap[String, AnalyzedClass] = {
    TreeMap[String, AnalyzedClass]() ++ analyzedClassMap.mapValues { analyzedClass =>
      val sortedApi = sortCompanions(analyzedClass.getApi)
      val sortedNameHashes = analyzedClass.getNameHashesList.asScala.sortWith(_.hashCode() > _.hashCode()).asJava

      AnalyzedClass
        .newBuilder(analyzedClass)
        .clearApi()
        .setApi(sortedApi)
        .clearNameHashes()
        .addAllNameHashes(sortedNameHashes)
        .build()
    }
  }

  def sortApis(apis: Schema.APIs): Schema.APIs = {
    val sortedInternal = sortAnalyzedClassMap(apis.getInternalMap.asScala.toMap).asJava
    val sortedExternal = sortAnalyzedClassMap(apis.getExternalMap.asScala.toMap).asJava

    Schema.APIs
      .newBuilder(apis)
      .clearInternal()
      .putAllInternal(sortedInternal)
      .clearExternal()
      .putAllExternal(sortedExternal)
      .build()
  }

  def apis(): Store[APIs] = {
    new Store[APIs](
      stream => reader.fromApis(shouldStoreApis = true)(format.read(Schema.APIs.getDefaultInstance, stream)),
      (stream, value) =>
        format.write(
          updateApisWithDefaultCompilationTimestamp(sortApis(writer.toApis(value, shouldStoreApis = true))),
          stream
        )
    )
  }

  def updateApisWithDefaultCompilationTimestamp(apis: Schema.APIs): Schema.APIs = {
    val internal = apis.getInternalMap.asScala.iterator
      .map { case (s: String, analyzedClass: AnalyzedClass) =>
        val foo = updateAnalyzedClassWithDefaultCompilationTimestamp(analyzedClass)
        s -> foo
      }
      .toMap
      .asJava
    val external = apis.getExternalMap.asScala.iterator
      .map { case (s: String, analyzedClass: AnalyzedClass) =>
        (s, updateAnalyzedClassWithDefaultCompilationTimestamp(analyzedClass))
      }
      .toMap
      .asJava

    Schema.APIs
      .newBuilder(apis)
      .clearInternal()
      .putAllInternal(internal)
      .clearExternal()
      .putAllExternal(external)
      .build()
  }

  def updateAnalyzedClassWithDefaultCompilationTimestamp(analyzedClass: AnalyzedClass): AnalyzedClass = {
    Schema.AnalyzedClass
      .newBuilder(analyzedClass)
      .setCompilationTimestamp(JarHelper.DEFAULT_TIMESTAMP)
      .build()
  }

  def miniSetup = new Store[MiniSetup](
    stream => reader.fromMiniSetup(format.read(Schema.MiniSetup.getDefaultInstance, stream)),
    (stream, value) => format.write(writer.toMiniSetup(value), stream)
  )

  object UsedNameOrdering extends Ordering[UsedName] {
    def compare(x: UsedName, y: UsedName): Int = {
      (x.getName + x.getScopesList.asScala.toString) compare (y.getName + y.getScopesList.asScala.toString)
    }
  }

  def sortValuesMap(m: Map[String, Values]): TreeMap[String, Values] = {
    TreeMap[String, Values]() ++ m.mapValues { value =>
      val sortedValues = value.getValuesList.asScala.sorted.asJava

      Values
        .newBuilder(value)
        .clearValues()
        .addAllValues(sortedValues)
        .build()
    }
  }

  def sortUsedNamesMap(usedNamesMap: Map[String, UsedNames]): TreeMap[String, UsedNames] = {
    TreeMap[String, UsedNames]() ++ usedNamesMap.mapValues { currentUsedNames =>
      val sortedUsedNames = currentUsedNames.getUsedNamesList.asScala.sorted(UsedNameOrdering).asJava

      UsedNames
        .newBuilder(currentUsedNames)
        .clearUsedNames()
        .addAllUsedNames(sortedUsedNames)
        .build()
    }
  }

  def sortClassDependencies(classDependencies: ClassDependencies): ClassDependencies = {
    val sortedInternal = sortValuesMap(classDependencies.getInternalMap.asScala.toMap).asJava
    val sortedExternal = sortValuesMap(classDependencies.getExternalMap.asScala.toMap).asJava

    ClassDependencies
      .newBuilder(classDependencies)
      .clearInternal()
      .putAllInternal(sortedInternal)
      .clearExternal()
      .putAllExternal(sortedExternal)
      .build()
  }

  def sortRelations(relations: Schema.Relations): Schema.Relations = {
    val sortedSrcProd = sortValuesMap(relations.getSrcProdMap.asScala.toMap).asJava
    val sortedLibraryDep = sortValuesMap(relations.getLibraryDepMap.asScala.toMap).asJava
    val sortedLibraryClassName = sortValuesMap(relations.getLibraryClassNameMap.asScala.toMap).asJava
    val sortedClasses = sortValuesMap(relations.getClassesMap.asScala.toMap).asJava
    val sortedProductClassName = sortValuesMap(relations.getProductClassNameMap.asScala.toMap).asJava
    val sortedNames = sortUsedNamesMap(relations.getNamesMap.asScala.toMap).asJava
    val sortedMemberRef = sortClassDependencies(relations.getMemberRef)
    val sortedLocalInheritance = sortClassDependencies(relations.getLocalInheritance)
    val sortedInheritance = sortClassDependencies(relations.getInheritance)

    Schema.Relations
      .newBuilder(relations)
      .clearSrcProd()
      .putAllSrcProd(sortedSrcProd)
      .clearLibraryDep()
      .putAllLibraryDep(sortedLibraryDep)
      .clearLibraryClassName()
      .putAllLibraryClassName(sortedLibraryClassName)
      .clearClasses()
      .putAllClasses(sortedClasses)
      .clearProductClassName()
      .putAllProductClassName(sortedProductClassName)
      .clearNames()
      .putAllNames(sortedNames)
      .clearMemberRef()
      .setMemberRef(sortedMemberRef)
      .clearLocalInheritance()
      .setLocalInheritance(sortedLocalInheritance)
      .clearInheritance()
      .setInheritance(sortedInheritance)
      .build()
  }

  def relations = new Store[Relations](
    stream => {
      val relations = format.read(
        Schema.Relations.getDefaultInstance,
        stream
      )
      reader.fromRelations(
        relationsMapper(relations, mappers.getReadMapper)
      )
    },
    (stream, value) => {
      val relations = writer.toRelations(value)
      format.write(
        sortRelations(relationsMapper(relations, mappers.getWriteMapper)),
        stream
      )
    }
  )

  // Note: this is now closed, we may be able to get rid of this code
  // Workaround for https://github.com/sbt/zinc/pull/532
  private[this] def relationsMapper(
    relations: Schema.Relations,
    mapper: GenericMapper
  ): Schema.Relations = {
    def convertToVirtualRefAndBack(path: String, mapFunction: VirtualFileRef => VirtualFileRef): String = {
      PlainVirtualFileConverter.converter
        .toPath(
          mapFunction(
            PlainVirtualFile(Paths.get(path))
          )
        )
        .toString
    }

    val updatedSourceProd = relations.getSrcProdMap.asScala.iterator
      .map { case (source: String, products: Values) =>
        val updatedValues =
          products.getValuesList.asScala.map(path => convertToVirtualRefAndBack(path, mapper.mapProductFile)).asJava
        convertToVirtualRefAndBack(source, mapper.mapSourceFile) ->
          Values.newBuilder(products).clearValues().addAllValues(updatedValues).build()
      }
      .toMap
      .asJava
    // The original code mutated this twice and I'm not totally sure why. Not sure if it is a bug or if the
    // scalapb version the mutations were applied sequentially. I've tried to write the code to apply the
    // mutations sequentially, assuming that is how that code works.
    val updatedLibraryDep = relations.getLibraryDepMap.asScala.iterator
      .map { case (source: String, binaries: Values) =>
        val updatedValues =
          binaries.getValuesList.asScala.map(path => convertToVirtualRefAndBack(path, mapper.mapBinaryFile)).asJava
        convertToVirtualRefAndBack(source, mapper.mapSourceFile) ->
          Values.newBuilder(binaries).clearValues().addAllValues(updatedValues).build()
      }
      .map { case (binary: String, values: Values) =>
        convertToVirtualRefAndBack(binary, mapper.mapBinaryFile) -> values
      }
      .toMap
      .asJava
    val updatedClasses = relations.getClassesMap.asScala.iterator
      .map { case (source: String, values: Values) =>
        convertToVirtualRefAndBack(source, mapper.mapSourceFile) -> values
      }
      .toMap
      .asJava

    Schema.Relations
      .newBuilder(relations)
      .clearSrcProd()
      .putAllSrcProd(updatedSourceProd)
      .clearLibraryDep()
      .putAllLibraryDep(updatedLibraryDep)
      .clearClasses()
      .putAllClasses(updatedClasses)
      .build()
//    _.update(
//      _.srcProd.foreach(_.modify {
//        case (source, products) =>
//          mapper.mapSourceFile(new File(source)).toString ->
//            products.update(_.values.foreach(_.modify(path => mapper.mapProductFile(new File(path)).toString)))
//      }),
//      _.libraryDep.foreach(_.modify {
//        case (source, binaries) =>
//          mapper.mapSourceFile(new File(source)).toString ->
//            binaries.update(_.values.foreach(_.modify(path => mapper.mapBinaryFile(new File(path)).toString)))
//      }),
//      _.libraryDep.foreach(_.modify {
//        case (binary, values) => mapper.mapBinaryFile(new File(binary)).toString -> values
//      }),
//      _.classes.foreach(_.modify {
//        case (source, values) => mapper.mapSourceFile(new File(source)).toString -> values
//      })
//    )
  }

  def sourceInfos = new Store[SourceInfos](
    stream => reader.fromSourceInfos(format.read(Schema.SourceInfos.getDefaultInstance, stream)),
    (stream, value) => format.write(writer.toSourceInfos(value), stream)
  )

  def stamps = new Store[Stamps](
    stream => reader.fromStamps(format.read(Schema.Stamps.getDefaultInstance, stream)),
    (stream, value) => format.write(writer.toStamps(value), stream)
  )
}

object AnxMapper {
  val rootPlaceholder = Paths.get("_ROOT_")
  def mappers(root: Path) = new ReadWriteMappers(new AnxReadMapper(root), new AnxWriteMapper(root))
  private[this] val stampCache = new scala.collection.mutable.HashMap[Path, (FileTime, Stamp)]
  def hashStamp(file: Path) = {
    val newTime = Files.getLastModifiedTime(file)
    stampCache.get(file) match {
      case Some((time, stamp)) if newTime.compareTo(time) <= 0 => stamp
      case _ =>
        val stamp = Stamper.forFarmHashP(file)
        stampCache += (file -> (newTime, stamp))
        stamp
    }
  }
}

final class AnxWriteMapper(root: Path) extends WriteMapper {
  private[this] val rootAbs = root.toAbsolutePath

  private[this] def mapFile(path: Path): Path = {
    if (path.startsWith(rootAbs)) {
      AnxMapper.rootPlaceholder.resolve(rootAbs.relativize(path))
    } else {
      path
    }
  }

  private[this] def mapFile(virtualFileRef: VirtualFileRef): Path = {
    mapFile(PlainVirtualFileConverter.converter.toPath(virtualFileRef))
  }

  override def mapBinaryFile(binaryFile: VirtualFileRef) = PlainVirtualFile(mapFile(binaryFile))
  override def mapBinaryStamp(file: VirtualFileRef, binaryStamp: Stamp) = {
    AnxMapper.hashStamp(PlainVirtualFileConverter.converter.toPath(file))
  }
  override def mapClasspathEntry(classpathEntry: Path) = mapFile(classpathEntry)
  override def mapJavacOption(javacOption: String) = javacOption
  override def mapMiniSetup(miniSetup: MiniSetup) = miniSetup
  override def mapProductFile(productFile: VirtualFileRef) = PlainVirtualFile(mapFile(productFile))
  override def mapProductStamp(file: VirtualFileRef, productStamp: Stamp) = {
    StampImpl.fromString(s"lastModified(${JarHelper.DEFAULT_TIMESTAMP})")
  }
  override def mapScalacOption(scalacOption: String) = scalacOption
  override def mapSourceDir(sourceDir: Path) = mapFile(sourceDir)
  override def mapSourceFile(sourceFile: VirtualFileRef) = PlainVirtualFile(mapFile(sourceFile))
  override def mapSourceStamp(file: VirtualFileRef, sourceStamp: Stamp) = sourceStamp
  override def mapOutputDir(outputDir: Path) = mapFile(outputDir)
}

final class AnxReadMapper(root: Path) extends ReadMapper {
  private[this] val rootAbs = root.toAbsolutePath

  private[this] def mapFile(virtualFileRef: VirtualFileRef): Path = {
    mapFile(PlainVirtualFileConverter.converter.toPath(virtualFileRef))
  }

  private[this] def mapFile(path: Path): Path = {
    if (path.startsWith(AnxMapper.rootPlaceholder)) {
      rootAbs.resolve(AnxMapper.rootPlaceholder.relativize(path))
    } else {
      path
    }
  }

  override def mapBinaryFile(file: VirtualFileRef) = PlainVirtualFile(mapFile(file))
  override def mapBinaryStamp(file: VirtualFileRef, stamp: Stamp) = {
    val path = PlainVirtualFileConverter.converter.toPath(file)
    if (AnxMapper.hashStamp(path) == stamp) {
      Stamper.forLastModifiedP(path)
    } else {
      stamp
    }
  }
  override def mapClasspathEntry(classpathEntry: Path) = mapFile(classpathEntry)
  override def mapJavacOption(javacOption: String) = javacOption
  override def mapOutputDir(dir: Path) = mapFile(dir)
  override def mapMiniSetup(miniSetup: MiniSetup) = miniSetup
  override def mapProductFile(file: VirtualFileRef) = PlainVirtualFile(mapFile(file))
  override def mapProductStamp(file: VirtualFileRef, productStamp: Stamp) = {
    Stamper.forLastModifiedP(PlainVirtualFileConverter.converter.toPath(file))
  }
  override def mapScalacOption(scalacOption: String) = scalacOption
  override def mapSourceDir(sourceDir: Path) = mapFile(sourceDir)
  override def mapSourceFile(sourceFile: VirtualFileRef) = PlainVirtualFile(mapFile(sourceFile))
  override def mapSourceStamp(file: VirtualFileRef, sourceStamp: Stamp) = sourceStamp
}
