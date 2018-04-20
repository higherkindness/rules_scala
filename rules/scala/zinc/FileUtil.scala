package annex

import java.io.IOException
import java.nio.file.attribute.BasicFileAttributes
import java.nio.file.FileVisitResult
import java.nio.file.FileAlreadyExistsException
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.StandardCopyOption
import java.nio.file.SimpleFileVisitor

class CopyFileVisitor(source: Path, target: Path) extends SimpleFileVisitor[Path] {
  override def preVisitDirectory(directory: Path, attributes: BasicFileAttributes) = {
    try Files.createDirectory(target.resolve(source.relativize(directory)))
    catch { case _: FileAlreadyExistsException => }
    FileVisitResult.CONTINUE
  }

  override def visitFile(file: Path, attributes: BasicFileAttributes) = {
    Files.copy(file, target.resolve(source.relativize(file)), StandardCopyOption.COPY_ATTRIBUTES)
    FileVisitResult.CONTINUE
  }
}

class DeleteFileVisitor extends SimpleFileVisitor[Path] {
  override def postVisitDirectory(directory: Path, error: IOException) = {
    Files.delete(directory)
    FileVisitResult.CONTINUE
  }

  override def visitFile(file: Path, attributes: BasicFileAttributes) = {
    Files.delete(file)
    FileVisitResult.CONTINUE
  }
}

object FileUtil {
  def copy(source: Path, target: Path) = Files.walkFileTree(source, new CopyFileVisitor(source, target))

  def delete(path: Path) = Files.walkFileTree(path, new DeleteFileVisitor)
}
