package annex

import com.google.devtools.build.lib.worker.WorkerProtocol

import scala.annotation.tailrec
import scala.collection.JavaConverters._

import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.InputStream
import java.io.PrintStream
import java.lang.SecurityManager
import java.nio.file.Paths
import java.nio.file.Files
import java.nio.charset.StandardCharsets.UTF_8
import java.security.Permission

object AnxWorker {

  final case class Env(
    isWorker  : Boolean,
    extraFlags: List[String]
  )

  private final class AnxExitTrappedException(val code: Int) extends Throwable

  private val ArgsPathString = raw"\@(.+)".r

  def main(args: Array[String]): Unit =
    args.toList match {
      case "--persistent_worker" :: extraFlags =>
        persistentWorkerMain(Env(true, extraFlags))
      case ArgsPathString(pathString) :: Nil =>
        val options = Options.read(
          Files.readAllLines(Paths.get(pathString), UTF_8).asScala.toList,
          Env(false, Nil))
        ZincRunner.main(options)
      case unexpected =>
        println("Unexpected args:")
        unexpected.foreach(v => println(s"  $v"))
        System.exit(-1)
    }

  private def persistentWorkerMain(env: Env): Unit = {
    val realIn = System.in
    val realOut = System.out
    val realErr = System.err

    System.setSecurityManager(new SecurityManager {
      val ExitVM = raw"exitVM\.(-?\d+)".r.unanchored
      override def checkPermission(permission: Permission): Unit = {
        permission.getName match {
          case ExitVM(code) => throw new AnxExitTrappedException(code.toInt)
          case _ =>
        }
      }
    })

    val buffer = new ByteArrayOutputStream
    val out = new PrintStream(buffer)

    System.setIn(new ByteArrayInputStream(Array.empty))
    System.setOut(out)
    System.setErr(out)

    persistentWorkerLoop(env, realIn, realOut, buffer)
  }

  @tailrec private def persistentWorkerLoop(
    env: Env,
    in: InputStream,
    out: PrintStream,
    buf: ByteArrayOutputStream
  ): Unit = {

    val request = WorkerProtocol.WorkRequest.parseDelimitedFrom(in)
    val clientArgs =  request.getArgumentsList.asScala.toList

    val code =
      try {
        val options = Options.read(clientArgs, env)
        ZincRunner.main(options)
        0
      } catch {
        case exit: AnxExitTrappedException => exit.code
        case e: Throwable =>
          println("The worker's task crashed!")
          e.printStackTrace()
          -1
      }

    WorkerProtocol.WorkResponse.newBuilder()
      .setOutput(buf.toString)
      .setExitCode(code)
      .build()
      .writeDelimitedTo(out)
    out.flush()

    buf.reset()

    persistentWorkerLoop(env, in, out, buf)
  }

}
