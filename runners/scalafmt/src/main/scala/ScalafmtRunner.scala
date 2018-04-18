package annex.scalafmt

import annex.worker.SimpleMain
import java.io.File
import java.nio.file.Files
import net.sourceforge.argparse4j.ArgumentParsers
import net.sourceforge.argparse4j.impl.Arguments
import org.scalafmt.Scalafmt
import org.scalafmt.config.Config
import scala.annotation.tailrec

object ScalafmtRunner extends SimpleMain {

  private[this] val parser = ArgumentParsers.newFor("scalafmt").addHelp(true).build
  parser.addArgument("--config").required(true).`type`(Arguments.fileType)
  parser.addArgument("input").`type`(Arguments.fileType)
  parser.addArgument("output").`type`(Arguments.fileType)

  protected[this] def work(args: Array[String]): Unit = {
    val namespace = parser.parseArgsOrFail(args)

    val source = new String(Files.readAllBytes(namespace.get[File]("input").toPath))

    val config = Config.fromHoconFile(namespace.get[File]("config")).get
    @tailrec
    def format(code: String): String = {
      val formatted = Scalafmt.format(code, config).get
      if (code == formatted) code else format(formatted)
    }
    val output = format(source)

    Files.write(namespace.get[File]("output").toPath, output.getBytes)
  }

}
