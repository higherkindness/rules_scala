package annex.zinc

import annex.compiler.FileUtil
import java.nio.file.{Files, Path}

trait ZincPersistence {
  def load(): Unit
  def save(): Unit
}

class FilePersistence(cacheDir: Path, analysisFiles: AnalysisFiles, classDir: Path) extends ZincPersistence {
  private[this] val cacheAnalysisFiles =
    AnalysisFiles(
      apis = cacheDir.resolve("apis.gz"),
      miniSetup = cacheDir.resolve("setup.gz"),
      relations = cacheDir.resolve("relations.gz"),
      sourceInfos = cacheDir.resolve("infos.gz"),
      stamps = cacheDir.resolve("stamps.gz"),
    )
  private[this] val cacheClassDir = cacheDir.resolve("classes")
  def load() = {
    if (Files.exists(cacheDir)) {
      Files.copy(cacheAnalysisFiles.apis, analysisFiles.apis)
      Files.copy(cacheAnalysisFiles.miniSetup, analysisFiles.miniSetup)
      Files.copy(cacheAnalysisFiles.relations, analysisFiles.relations)
      Files.copy(cacheAnalysisFiles.sourceInfos, analysisFiles.sourceInfos)
      Files.copy(cacheAnalysisFiles.stamps, analysisFiles.stamps)
      FileUtil.copy(cacheClassDir, classDir)
    }
  }
  def save() = {
    if (Files.exists(cacheDir)) {
      FileUtil.delete(cacheDir)
    }
    Files.createDirectories(cacheDir)
    Files.copy(analysisFiles.apis, cacheAnalysisFiles.apis)
    Files.copy(analysisFiles.miniSetup, cacheAnalysisFiles.miniSetup)
    Files.copy(analysisFiles.relations, cacheAnalysisFiles.relations)
    Files.copy(analysisFiles.sourceInfos, cacheAnalysisFiles.sourceInfos)
    Files.copy(analysisFiles.stamps, cacheAnalysisFiles.stamps)
    FileUtil.copy(classDir, cacheClassDir)
  }
}

object NullPersistence extends ZincPersistence {
  def load() = ()
  def save() = ()
}
