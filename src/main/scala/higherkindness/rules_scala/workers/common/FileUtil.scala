package higherkindness.rules_scala
package workers.common

import scala.annotation.tailrec
import java.io.IOException
import java.nio.channels.FileChannel
import java.nio.file.{FileAlreadyExistsException, FileVisitResult, Files, OpenOption, Path, SimpleFileVisitor, StandardCopyOption, StandardOpenOption}
import java.nio.file.attribute.BasicFileAttributes
import java.security.SecureRandom
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

  private def lock[A](lockFile: Path)(f: => A): A = {
    Files.createDirectories(lockFile.getParent)
    try Files.createFile(lockFile)
    catch { case _: FileAlreadyExistsException => }
    val channel = FileChannel.open(lockFile, StandardOpenOption.WRITE)
    try {
      val lock = channel.lock()
      try f
      finally lock.release()
    } finally channel.close()
  }

  /**
    We call `extractZipIdempotentally` in `Deps` to avoid a potential race condition. `extractZipIdempotentally` guarantees
    that the zip file will be extracted completely once and only once. If we didn't do this, we would either
    perform the work every time, mitigating the advatnages of the extracted dependencies cache, or face a race condition.

    The race condition occurs if projects B and C depend on project A; both B and C could begin almost simulatenously. Extracting a zip is not atomic.
    If B begins extracting first, and C simply checks if the output directory exists, it could begin compiling while B is still extracting the dependency.
    Alternatives to pessimistic locking include extracting to arbitrary temporary destinations then atomically moving in place, but that presents some other challenges.
  **/
  def extractZipIdempotently(archive: Path, output: Path): Unit =
    lock(output.getParent.resolve(s".${output.getFileName}.lock")) {
      if (Files.exists(output)) ()
      else extractZip(archive, output)
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
