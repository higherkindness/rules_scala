package higherkindness.rules_scala
package workers.zinc.compile

import com.google.devtools.build.buildjar.jarhelper.JarHelper
import java.io.{File, InputStream, OutputStream, OutputStreamWriter}
import java.nio.charset.StandardCharsets
import java.nio.file.{Files, NoSuchFileException, Path, Paths}
import java.nio.file.attribute.FileTime
import java.util.concurrent.ConcurrentHashMap
import java.util.zip.{GZIPInputStream, GZIPOutputStream}
import java.util.Optional
import sbt.internal.inc.binary.converters.{ProtobufReaders, ProtobufWriters}
import sbt.internal.inc.Schema.Type.{Projection, Structure}
import sbt.internal.inc.{APIs, Analysis, PlainVirtualFile, PlainVirtualFileConverter, Relations, Schema, SourceInfos, Stamp => StampImpl, Stamper, Stamps}
import sbt.internal.inc.Schema.{Access, AnalyzedClass, Annotation, AnnotationArgument, ClassDefinition, ClassDependencies, ClassLike, Companions, MethodParameter, NameHash, ParameterList, Path => SchemaPath, Qualifier, Type, TypeParameter, UsedName, UsedNames, Values}
import sbt.internal.shaded.com.google.protobuf.GeneratedMessageV3
import sbt.io.IO
import scala.math.Ordering
import scala.collection.mutable.StringBuilder
import scala.collection.immutable.TreeMap
import xsbti.compile.analysis.{GenericMapper, ReadMapper, ReadWriteMappers, Stamp, WriteMapper}
import xsbti.compile.{AnalysisContents, AnalysisStore, MiniSetup}
import scala.collection.JavaConverters._
import xsbti.VirtualFileRef
import java.util.Objects

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
      val miniSetup = analyses.miniSetup().read(files.miniSetup)
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
    analyses.miniSetup().write(files.miniSetup, miniSetup)
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

  /*
   * Important note: The following functions should only be called _after_ the internals of the classes have been sorted
   * We can use hashCode() on strings, bools, and ints, which hash independently of memory location, but not any other objects, which can vary
   */
  def hashAnnotationArgument(annotationArgument: AnnotationArgument): Int =
    Objects.hash(annotationArgument.getName(), annotationArgument.getValue())
  def hashNameHash(nameHash: NameHash): Int = Objects.hash(nameHash.getName(), nameHash.getHash())
  def hashPath(path: SchemaPath): Int = Objects.hash(
    path
      .getComponentsList()
      .asScala
      .map(pathComponent =>
        if (pathComponent.hasId()) {
          Objects.hash(
            1,
            pathComponent.getId().getId()
          )
        } else if (pathComponent.hasThis()) {
          Objects.hash(
            2
          )
        } else if (pathComponent.hasSuper()) {
          Objects.hash(
            3,
            hashPath(pathComponent.getSuper().getQualifier())
          )
        } else {
          throw new Error("Unrecognized pathComponent type")
        }
      )
      .toSeq: _*
  )
  def hashType(t: Type): Int = if (t.hasParameterRef()) {
    Objects.hash(
      1,
      t.getParameterRef().getId()
    )
  } else if (t.hasParameterized()) {
    Objects.hash(
      2,
      hashType(t.getParameterized().getBaseType()),
      Objects.hash(t.getParameterized().getTypeArgumentsList().asScala.map(hashType).toSeq: _*)
    )
  } else if (t.hasStructure()) {
    Objects.hash(
      3,
      Objects.hash(t.getStructure().getParentsList().asScala.map(hashType).toSeq: _*),
      Objects.hash(t.getStructure().getDeclaredList().asScala.map(hashClassDefinition).toSeq: _*),
      Objects.hash(t.getStructure().getInheritedList().asScala.map(hashClassDefinition).toSeq: _*)
    )
  } else if (t.hasPolymorphic()) {
    Objects.hash(
      4,
      hashType(t.getPolymorphic().getBaseType()),
      Objects.hash(t.getPolymorphic().getTypeParametersList().asScala.map(hashTypeParameter).toSeq: _*)
    )
  } else if (t.hasConstant()) {
    Objects.hash(
      5,
      hashType(t.getConstant().getBaseType()),
      t.getConstant().getValue()
    )
  } else if (t.hasExistential()) {
    Objects.hash(
      6,
      hashType(t.getExistential().getBaseType()),
      Objects.hash(t.getExistential().getClauseList().asScala.map(hashTypeParameter).toSeq: _*)
    )
  } else if (t.hasSingleton()) {
    Objects.hash(
      7,
      hashPath(t.getSingleton().getPath())
    )
  } else if (t.hasProjection()) {
    Objects.hash(
      8,
      t.getProjection().getId(),
      hashType(t.getProjection().getPrefix())
    )
  } else if (t.hasAnnotated()) {
    Objects.hash(
      9,
      hashType(t.getAnnotated().getBaseType()),
      Objects.hash(t.getAnnotated().getAnnotationsList().asScala.map(hashAnnotation).toSeq: _*)
    )
  } else if (t.hasEmptyType()) {
    Objects.hash(
      10
    )
  } else {
    throw new Error("Unrecognized type type")
  }
  def hashQualifier(qualifier: Qualifier): Int = if (qualifier.hasThisQualifier()) {
    1
  } else if (qualifier.hasIdQualifier()) {
    2
  } else if (qualifier.hasUnqualified()) {
    3
  } else {
    throw new Error("Unrecognized qualifier type")
  }
  def hashAccess(access: Access): Int = if (access.hasPublic()) {
    Objects.hash(1)
  } else if (access.hasProtected()) {
    Objects.hash(
      2,
      hashQualifier(access.getProtected().getQualifier())
    )
  } else if (access.hasPrivate()) {
    Objects.hash(
      3,
      hashQualifier(access.getPrivate().getQualifier())
    )
  } else {
    throw new Error("Unrecognized access type")
  }
  def hashMethodParameter(methodParameter: MethodParameter): Int = Objects.hash(
    methodParameter.getName(),
    hashType(methodParameter.getType()),
    methodParameter.getHasDefault(),
    methodParameter.getModifier().ordinal()
  )
  def hashParameterList(parameterList: ParameterList): Int = Objects.hash(
    Objects.hash(parameterList.getParametersList().asScala.map(hashMethodParameter).toSeq: _*),
    parameterList.getIsImplicit()
  )
  def hashAnnotation(annotation: Annotation): Int = Objects.hash(
    hashType(annotation.getBase()),
    Objects.hash(annotation.getArgumentsList().asScala.map(hashAnnotationArgument).toSeq: _*)
  )
  def hashClassDefinition(classDefinition: ClassDefinition): Int = {
    val extraHash = if (classDefinition.hasClassLikeDef()) {
      Objects.hash(
        1,
        Objects.hash(
          classDefinition.getClassLikeDef().getTypeParametersList().asScala.map(hashTypeParameter).toSeq: _*
        ),
        classDefinition.getClassLikeDef().getDefinitionType().ordinal()
      )
    } else if (classDefinition.hasDefDef()) {
      Objects.hash(
        2,
        Objects.hash(classDefinition.getDefDef().getTypeParametersList().asScala.map(hashTypeParameter).toSeq: _*),
        Objects.hash(classDefinition.getDefDef().getValueParametersList().asScala.map(hashParameterList).toSeq: _*),
        hashType(classDefinition.getDefDef().getReturnType())
      )
    } else if (classDefinition.hasValDef()) {
      Objects.hash(
        3,
        hashType(classDefinition.getValDef().getType())
      )
    } else if (classDefinition.hasVarDef()) {
      Objects.hash(
        4,
        hashType(classDefinition.getVarDef().getType())
      )
    } else if (classDefinition.hasTypeAlias()) {
      Objects.hash(
        5,
        Objects.hash(classDefinition.getTypeAlias().getTypeParametersList().asScala.map(hashTypeParameter).toSeq: _*),
        hashType(classDefinition.getTypeAlias().getType())
      )
    } else if (classDefinition.hasTypeDeclaration()) {
      Objects.hash(
        6,
        Objects.hash(
          classDefinition.getTypeDeclaration().getTypeParametersList().asScala.map(hashTypeParameter).toSeq: _*
        ),
        hashType(classDefinition.getTypeDeclaration().getLowerBound()),
        hashType(classDefinition.getTypeDeclaration().getUpperBound())
      )
    } else {
      throw new Error("Unrecognized extra type")
    }

    Objects.hash(
      classDefinition.getName(),
      hashAccess(classDefinition.getAccess()),
      classDefinition.getModifiers().getFlags(),
      Objects.hash(classDefinition.getAnnotationsList().asScala.map(hashAnnotation).toSeq: _*),
      extraHash
    )
  }
  def hashTypeParameter(typeParameter: TypeParameter): Int = Objects.hash(
    typeParameter.getId(),
    Objects.hash(typeParameter.getAnnotationsList().asScala.map(hashAnnotation).toSeq: _*),
    Objects.hash(typeParameter.getTypeParametersList().asScala.map(hashTypeParameter).toSeq: _*),
    typeParameter.getVariance().ordinal(),
    hashType(typeParameter.getLowerBound()),
    hashType(typeParameter.getUpperBound())
  )

  def sortTypeParameters(typeParameters: Seq[TypeParameter]): Seq[TypeParameter] = {
    // TODO: Ensure that we're internally sorting the type parameters here
    typeParameters.map(sortTypeParameter).sortWith(hashTypeParameter(_) > hashTypeParameter(_))
  }
  def sortType(t: Type): Type = t // TODO: Actually sort internals here
  def sortClassDefinition(classDefinition: ClassDefinition): ClassDefinition =
    classDefinition // TODO: Actually sort internals here

  def sortAnnotation(annotation: Annotation): Annotation = {
    val sortedArguments =
      annotation.getArgumentsList.asScala.sortWith(hashAnnotationArgument(_) > hashAnnotationArgument(_)).asJava
    Annotation
      .newBuilder(annotation)
      .clearArguments()
      .addAllArguments(sortedArguments)
      .build()
  }

  def sortTypeParameter(typeParameter: TypeParameter): TypeParameter = {
    val sortedAnnotations =
      typeParameter.getAnnotationsList.asScala
        .map(sortAnnotation)
        .sortWith(hashAnnotation(_) > hashAnnotation(_))
        .asJava
    val sortedTypeParameters = sortTypeParameters(typeParameter.getTypeParametersList.asScala.toSeq).asJava
    // TODO: Sort lower/upper bound field on this

    TypeParameter
      .newBuilder(typeParameter)
      .clearAnnotations()
      .addAllAnnotations(sortedAnnotations)
      .clearTypeParameters()
      .addAllTypeParameters(sortedTypeParameters)
      .build()
  }

  def sortStructure(structure: Structure): Structure = {
    val sortedParents = structure.getParentsList.asScala.map(sortType).sortWith(hashType(_) < hashType(_)).asJava
    val sortedDeclared = structure.getDeclaredList.asScala
      .map(sortClassDefinition)
      .sortWith(hashClassDefinition(_) < hashClassDefinition(_))
      .asJava
    val sortedInherited = structure.getInheritedList.asScala
      .map(sortClassDefinition)
      .sortWith(hashClassDefinition(_) < hashClassDefinition(_))
      .asJava

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

  def sortClassLike(classLike: ClassLike): ClassLike = {
    val sortedAnnotations =
      classLike.getAnnotationsList.asScala.map(sortAnnotation).sortWith(hashAnnotation(_) > hashAnnotation(_)).asJava
    val sortedStructure = sortStructure(classLike.getStructure)
    val sortedSavedAnnotations = classLike.getSavedAnnotationsList.asScala.sorted.asJava
    val sortedChildrenOfSealedClass =
      classLike.getChildrenOfSealedClassList.asScala.map(sortType).sortWith(hashType(_) < hashType(_)).asJava
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
      val sortedNameHashes = analyzedClass.getNameHashesList.asScala.sortWith(hashNameHash(_) > hashNameHash(_)).asJava

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
        s -> updateAnalyzedClassWithDefaultCompilationTimestamp(analyzedClass)
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

  def sortMiniSetup(miniSetup: Schema.MiniSetup): Schema.MiniSetup = {
    val sortedMiniOptions = sortMiniOptions(miniSetup.getMiniOptions)
    val sortedExtra = miniSetup.getExtraList.asScala.sortBy(_.getFirst).asJava

    Schema.MiniSetup
      .newBuilder(miniSetup)
      .clearMiniOptions()
      .setMiniOptions(sortedMiniOptions)
      .clearExtra()
      .addAllExtra(sortedExtra)
      .build()
  }

  def sortMiniOptions(miniOptions: Schema.MiniOptions): Schema.MiniOptions = {
    val sortedClasspathHash = miniOptions.getClasspathHashList.asScala.sortBy(_.getPath).asJava
    val sortedScalacOptions = miniOptions.getScalacOptionsList.asScala.sorted.asJava
    val sortedJavacOptions = miniOptions.getJavacOptionsList.asScala.sorted.asJava

    Schema.MiniOptions
      .newBuilder(miniOptions)
      .clearClasspathHash()
      .addAllClasspathHash(sortedClasspathHash)
      .clearScalacOptions()
      .addAllScalacOptions(sortedScalacOptions)
      .clearJavacOptions()
      .addAllJavacOptions(sortedJavacOptions)
      .build()
  }

  def miniSetup(): Store[MiniSetup] = {
    new Store[MiniSetup](
      stream => reader.fromMiniSetup(format.read(Schema.MiniSetup.getDefaultInstance, stream)),
      (stream, value) =>
        format.write(
          sortMiniSetup(writer.toMiniSetup(value)),
          stream
        )
    )
  }

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
  private[this] val stampCache = new ConcurrentHashMap[Path, (FileTime, Stamp)]
  def hashStamp(file: Path) = {
    val newTime = Files.getLastModifiedTime(file)
    stampCache.get(file) match {
      case (time, stamp) if newTime.compareTo(time) <= 0 => stamp
      case _ =>
        val stamp = Stamper.forFarmHashP(file)
        stampCache.put(file, (newTime, stamp))
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
