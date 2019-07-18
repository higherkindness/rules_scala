package higherkindness.rules_scala
package workers.zinc.compile

import workers.common.FileUtil

import java.nio.file.Files
import java.nio.file.Path

trait ZincPersistence {
  def load(): Unit
  def save(): Unit
}

class FilePersistence(cacheDir: Path, analysisFiles: AnalysisFiles, jar: Path) extends ZincPersistence {
  private[this] val cacheAnalysisFiles =
    AnalysisFiles(
      apis = cacheDir.resolve("apis.gz"),
      miniSetup = cacheDir.resolve("setup.gz"),
      relations = cacheDir.resolve("relations.gz"),
      sourceInfos = cacheDir.resolve("infos.gz"),
      stamps = cacheDir.resolve("stamps.gz")
    )
  private[this] val cacheJar = cacheDir.resolve("classes.jar")

  /**
   * Existance indicates that files are incomplete.
   */
  private[this] val tmpMarker = cacheDir.resolve(".tmp")

  def load() = {
    if (Files.exists(cacheDir) && Files.notExists(tmpMarker)) {
      Files.copy(cacheAnalysisFiles.apis, analysisFiles.apis)
      Files.copy(cacheAnalysisFiles.miniSetup, analysisFiles.miniSetup)
      Files.copy(cacheAnalysisFiles.relations, analysisFiles.relations)
      Files.copy(cacheAnalysisFiles.sourceInfos, analysisFiles.sourceInfos)
      Files.copy(cacheAnalysisFiles.stamps, analysisFiles.stamps)
      Files.copy(cacheJar, jar)
    }
  }
  def save() = {
    if (Files.exists(cacheDir)) {
      FileUtil.delete(cacheDir)
    }
    Files.createDirectories(cacheDir)
    Files.createFile(tmpMarker)
    Files.copy(analysisFiles.apis, cacheAnalysisFiles.apis)
    Files.copy(analysisFiles.miniSetup, cacheAnalysisFiles.miniSetup)
    Files.copy(analysisFiles.relations, cacheAnalysisFiles.relations)
    Files.copy(analysisFiles.sourceInfos, cacheAnalysisFiles.sourceInfos)
    Files.copy(analysisFiles.stamps, cacheAnalysisFiles.stamps)
    Files.copy(jar, cacheJar)
    Files.delete(tmpMarker)
  }
}

object NullPersistence extends ZincPersistence {
  def load() = ()
  def save() = ()
}
