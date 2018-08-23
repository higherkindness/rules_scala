package annex.zinc

import java.io.File
import java.nio.file.{Files, Path, StandardCopyOption}
import java.util.zip.ZipInputStream
import sbt.internal.inc.Relations
import scala.annotation.tailrec
import xsbti.compile.PerClasspathEntryLookup

sealed trait Dep {
  def file: Path
  def classpath: Path
}

case class LibraryDep(file: Path) extends Dep {
  def classpath = file
}

case class DepAnalysisFiles(apis: Path, relations: Path)

case class ExternalDep(file: Path, classpath: Path, analysis: DepAnalysisFiles) extends Dep

object Dep {
  def create(classpath: Seq[Path], analyses: Map[Path, (Path, DepAnalysisFiles)]): Seq[Dep] = {
    val roots = scala.collection.mutable.Set[Path]()
    classpath.flatMap { original =>
      analyses.get(original).fold[Option[Dep]](Some(LibraryDep(original))) { analysis =>
        val root = analysis._1
        if (roots.add(root)) {
          val fileStream = Files.newInputStream(original)
          try {
            val zipStream = new ZipInputStream(fileStream)

            @tailrec
            def next(): Unit = {
              zipStream.getNextEntry match {
                case null =>
                case entry if entry.isDirectory =>
                  zipStream.closeEntry()
                  next()
                case entry =>
                  val file = root.resolve(entry.getName)
                  Files.createDirectories(file.getParent)
                  Files.copy(zipStream, file, StandardCopyOption.REPLACE_EXISTING)
                  zipStream.closeEntry()
                  next()
              }
            }
            next()
          } finally {
            fileStream.close()
          }
          Some(ExternalDep(original, root, analysis._2))
        } else {
          None
        }
      }
    }
  }

  def used(deps: Iterable[Dep], relations: Relations, lookup: PerClasspathEntryLookup): Dep => Boolean = {
    val externalDeps = relations.allExternalDeps
    val libraryDeps = relations.allLibraryDeps
    ({
      case ExternalDep(file, _, _) => externalDeps.exists(lookup.definesClass(file.toFile).apply)
      case LibraryDep(file)        => libraryDeps(file.toAbsolutePath.toFile)
    })
  }
}
