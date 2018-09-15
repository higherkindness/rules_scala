package annex.scalafmt

import annex.worker.WorkerMain
import java.io.File
import java.nio.charset.Charset
import java.nio.file.Files
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import net.sourceforge.argparse4j.inf.Namespace
import org.scalafmt.Scalafmt
import org.scalafmt.config.Config
import org.scalafmt.util.FileOps
import scala.annotation.tailrec
import scala.io.Codec

object ScalafmtRunner extends WorkerMain[Unit] {

  protected[this] def init(args: Option[Array[String]]): Unit = {

  }

  protected[this] def work(worker: Unit, args: Array[String]): Unit = {

    val parser = ArgumentParsers.newFor("scalafmt").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build
    parser.addArgument("--config").required(true).`type`(Arguments.fileType)
    parser.addArgument("input").`type`(Arguments.fileType)
    parser.addArgument("output").`type`(Arguments.fileType)

    val namespace = parser.parseArgsOrFail(args)

    val source = FileOps.readFile(namespace.get[File]("input"))(Codec.UTF8)

    System.getenv.forEach((name, value) => println(s"$name: $value"))

    if (namespace.get[File]("input").toPath.toString.contains("Features")) {
      println(source)
    }

    val config = Config.fromHoconFile(namespace.get[File]("config")).get
    @tailrec
    def format(code: String): String = {
      val formatted = Scalafmt.format(code, config).get
      if (code == formatted) code else format(formatted)
    }

    val output = try {
      format(source)
    } catch {
      case e: Throwable => {
        System.err.println(Console.YELLOW + "WARN: " + Console.WHITE + "Unable to format file due to bug in scalafmt")
        System.err.println(Console.YELLOW + "WARN: " + Console.WHITE + e)
        source
      }
    }

    Files.write(namespace.get[File]("output").toPath, output.getBytes)
  }

}
