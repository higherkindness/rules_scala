package annex.scalafmt

import higherkindness.rules_scala.common.worker.WorkerMain
import higherkindness.rules_scala.workers.common.Color
import java.io.File
import java.nio.file.Files
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import org.scalafmt.Scalafmt
import org.scalafmt.config.Config
import org.scalafmt.util.FileOps
import scala.annotation.tailrec
import scala.io.Codec

object ScalafmtRunner extends WorkerMain[Unit] {

  protected[this] def init(args: Option[Array[String]]): Unit = {}

  protected[this] def work(worker: Unit, args: Array[String]): Unit = {

    val parser = ArgumentParsers.newFor("scalafmt").addHelp(true).defaultFormatWidth(80).fromFilePrefix("@").build
    parser.addArgument("--config").required(true).`type`(Arguments.fileType)
    parser.addArgument("input").`type`(Arguments.fileType)
    parser.addArgument("output").`type`(Arguments.fileType)

    val namespace = parser.parseArgsOrFail(args)

    val source = FileOps.readFile(namespace.get[File]("input"))(Codec.UTF8)

    val config = Config.fromHoconFile(namespace.get[File]("config")).get
    @tailrec
    def format(code: String): String = {
      val formatted = Scalafmt.format(code, config).get
      if (code == formatted) code else format(formatted)
    }

    val output =
      try {
        format(source)
      } catch {
        case e @ (_: org.scalafmt.Error | _: scala.meta.parsers.ParseException) => {
          System.err.println(Color.Warning("Unable to format file due to bug in scalafmt"))
          System.err.println(Color.Warning(e.toString))
          source
        }
      }

    Files.write(namespace.get[File]("output").toPath, output.getBytes)
  }

}
