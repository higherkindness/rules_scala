package annex

import java.nio.file.Files
import java.nio.file.Path

import xsbti.compile.AnalysisContents
import xsbti.compile.FileAnalysisStore

trait Persistence {
  def load(): Option[AnalysisContents]
  def save(contents: AnalysisContents)
}

class FilePersistence(cacheDir: Path, outputDir: Path) extends Persistence {
  private[this] val classDir = cacheDir.resolve("classes")
  private[this] val analysisStore = FileAnalysisStore.getDefault(cacheDir.resolve("analysis.gz").toFile)
  def load() = {
    if (Files.exists(classDir)) {
      FileUtil.copy(classDir, outputDir)
    }
    analysisStore.get().map[Option[AnalysisContents]](Some(_)).orElse(None)
  }
  def save(contents: AnalysisContents) = {
    if (Files.exists(cacheDir)) {
      FileUtil.delete(cacheDir)
    }
    Files.createDirectories(cacheDir)
    FileUtil.copy(outputDir, classDir)
    analysisStore.set(contents)
  }
}

object NullPersistence extends Persistence {
  def load() = None
  def save(contents: AnalysisContents) = ()
}
