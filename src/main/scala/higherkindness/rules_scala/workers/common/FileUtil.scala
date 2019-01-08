package higherkindness.rules_scala
package workers.common

import scala.annotation.tailrec

import java.io.IOException
import java.nio.file.FileAlreadyExistsException
import java.nio.file.FileVisitResult
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.SimpleFileVisitor
import java.nio.file.StandardCopyOption
import java.nio.file.attribute.BasicFileAttributes
import java.util.zip.{ZipEntry, ZipInputStream, ZipOutputStream}

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

class ZipFileVisitor(root: Path, zip: ZipOutputStream) extends SimpleFileVisitor[Path] {
  override def visitFile(file: Path, attributes: BasicFileAttributes) = {
    val entry = new ZipEntry(root.relativize(file).toString())
    zip.putNextEntry(entry)
    Files.copy(file, zip)
    zip.closeEntry()
    FileVisitResult.CONTINUE
  }
}

object FileUtil {
  def copy(source: Path, target: Path) = Files.walkFileTree(source, new CopyFileVisitor(source, target))

  def delete(path: Path) = Files.walkFileTree(path, new DeleteFileVisitor)

  def createZip(input: Path, archive: Path) = {
    val zip = new ZipOutputStream(Files.newOutputStream(archive))
    try {
      Files.walkFileTree(input, new ZipFileVisitor(input, zip))
    } finally {
      zip.close()
    }
  }

  def extractZip(archive: Path, output: Path) = {
    val fileStream = Files.newInputStream(archive)
    try {
      val zipStream = new ZipInputStream(fileStream)
      @tailrec
      def next(files: List[Path]): List[Path] = {
        zipStream.getNextEntry match {
          case null => files
          case entry if entry.isDirectory =>
            zipStream.closeEntry()
            next(files)
          case entry =>
            val file = output.resolve(entry.getName)
            Files.createDirectories(file.getParent)
            Files.copy(zipStream, file, StandardCopyOption.REPLACE_EXISTING)
            zipStream.closeEntry()
            next(file :: files)
        }
      }
      next(Nil)
    } finally {
      fileStream.close()
    }
  }
}
