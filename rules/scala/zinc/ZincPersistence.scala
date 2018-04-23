package annex.zinc

import java.nio.file.{Files, Path}

trait ZincPersistence {
  def load(): Unit
  def save(): Unit
}

class FilePersistence(cacheDir: Path, analysisFiles: AnalysisFiles, classDir: Path) extends ZincPersistence {
  private[this] val cacheAnalysisFiles =
    AnalysisFiles(cacheDir.resolve("analysis.gz"), cacheDir.resolve("apis.gz"))
  private[this] val cacheClassDir = cacheDir.resolve("classes")
  def load() = {
    if (Files.exists(cacheDir)) {
      Files.copy(cacheAnalysisFiles.analysis, analysisFiles.analysis)
      Files.copy(cacheAnalysisFiles.apis, analysisFiles.apis)
      FileUtil.copy(cacheClassDir, classDir)
    }
  }
  def save() = {
    if (Files.exists(cacheDir)) {
      FileUtil.delete(cacheDir)
    }
    Files.createDirectories(cacheDir)
    Files.copy(analysisFiles.analysis, cacheAnalysisFiles.analysis)
    Files.copy(analysisFiles.apis, cacheAnalysisFiles.apis)
    FileUtil.copy(classDir, cacheClassDir)
  }
}

object NullPersistence extends ZincPersistence {
  def load() = ()
  def save() = ()
}
