package higherkindness.rules_scala
package workers.jacoco.instrumenter

import common.args.implicits._
import common.worker.WorkerMain

import java.io.BufferedInputStream
import java.io.BufferedOutputStream
import java.net.URI
import java.nio.file.Files
import java.nio.file.FileSystems
import java.nio.file.FileVisitResult
import java.nio.file.Path
import java.nio.file.Paths
import java.nio.file.SimpleFileVisitor
import java.nio.file.StandardCopyOption
import java.nio.file.StandardOpenOption
import java.nio.file.attribute.BasicFileAttributes
import java.util.Collections
import java.util.{List => JList}
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import org.jacoco.core.instr.Instrumenter
import org.jacoco.core.runtime.OfflineInstrumentationAccessGenerator
import scala.collection.JavaConverters._

object JacocoInstrumenter extends WorkerMain[Unit] {
  private[this] val argParser = {
    val parser = ArgumentParsers.newFor("jacoco-instrumenter").addHelp(true).fromFilePrefix("@").build
    parser
      .addArgument("--jar")
      .action(Arguments.append)
      .help("jar to instrument")
      .metavar("inpath=outpath")
      .nargs("+")
    parser
  }

  override def init(args: Option[Array[String]]): Unit = ()

  override def work(ctx: Unit, args: Array[String]): Unit = {
    val namespace = argParser.parseArgs(args)

    val pathPairs: List[(Path, Path)] = namespace
      .getList[JList[String]]("jar")
      .asScala
      .flatMap(_.asScala)
      .map(other =>
        other.split("=") match {
          case Array(in, out) => (Paths.get(in), Paths.get(out))
          case _ =>
            sys.error("expected input=output for argument: " + other)
        }
      )
      .toList

    val jacoco = new Instrumenter(new OfflineInstrumentationAccessGenerator)

    pathPairs.foreach {
      case (inPath, outPath) =>
        val inFS = FileSystems.newFileSystem(inPath, null)
        val outFS =
          FileSystems.newFileSystem(URI.create("jar:" + outPath.toUri), Collections.singletonMap("create", "true"))

        val roots = inFS.getRootDirectories.asScala.toList
        val instrumentVisitor = new SimpleFileVisitor[Path] {
          override def visitFile(inPath: Path, attrs: BasicFileAttributes): FileVisitResult = {
            val outPath = outFS.getPath(inPath.toString)
            Files.createDirectories(outPath.getParent)
            if (inPath.toString.endsWith(".class")) {
              val inStream = new BufferedInputStream(Files.newInputStream(inPath))
              val outStream = new BufferedOutputStream(Files.newOutputStream(outPath, StandardOpenOption.CREATE_NEW))
              jacoco.instrument(inStream, outStream, inPath.toString)
              inStream.close()
              outStream.close()
              Files.copy(inPath, outFS.getPath(outPath.toString + ".uninstrumented"))
            } else {
              Files.copy(inPath, outPath)
            }
            FileVisitResult.CONTINUE
          }
        }

        roots.foreach(Files.walkFileTree(_, instrumentVisitor))

        inFS.close()
        outFS.close()
    }

  }
}
