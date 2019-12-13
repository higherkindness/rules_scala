package higherkindness.rules_scala
package workers.zinc.compile

import workers.common.FileUtil
import java.math.BigInteger
import java.nio.file.{Files, Path}
import java.security.MessageDigest

import sbt.internal.inc.Relations

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

  def sha256(file: Path): String = {
    val digest = MessageDigest.getInstance("SHA-256")
    new BigInteger(1, digest.digest(Files.readAllBytes(file))).toString(16)
  }

  def create(depsCache: Option[Path], classpath: Seq[Path], analyses: Map[Path, (Path, DepAnalysisFiles)]): Seq[Dep] = {
    val roots = scala.collection.mutable.Set[Path]()
    classpath.flatMap { original =>
      analyses.get(original).fold[Option[Dep]](Some(LibraryDep(original))) { analysis =>
        val root = analysis._1
        if (roots.add(root)) {
          depsCache match {
            case Some(cacheRoot) => {
              val cachedPath = cacheRoot.resolve(sha256(original))
              FileUtil.extractZipIdempotently(original, cachedPath)
              Some(ExternalDep(original, cachedPath, analysis._2))
            }
            case _ => {
              FileUtil.extractZip(original, root)
              Some(ExternalDep(original, root, analysis._2))
            }
          }
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
