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

  private final class AnxExitTrappedException(val code: Int) extends Throwable

  private val ArgsPathString = raw"\@(.+)".r

  def main(f: Options => Unit)(args: Array[String]): Unit =
    mainWithState[Unit](
      _ => (),
      (_, options) => f(options)
    )(args)

  def mainWithState[S](
    fi: (Env) => S,
    ff: (S, Options) => S
  )(args: Array[String]): Unit =
    args.toList match {
      case "--persistent_worker" :: extraFlags =>
        val env = Env(true, extraFlags)
        persistentWorkerMain(env, fi, ff)
      case ArgsPathString(pathString) :: Nil =>
        val env = Env(false, Nil)
        val options = Options.read(
          Files.readAllLines(Paths.get(pathString), UTF_8).asScala.toList,
          env)
        ff(fi(env), options)
      case unexpected =>
        println("Unexpected args:")
        unexpected.foreach(v => println(s"  $v"))
        System.exit(-1)
    }

  private def persistentWorkerMain[S](
    env: Env,
    fi: (Env) => S,
    ff: (S, Options) => S
  ): Unit = {

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

    persistentWorkerLoop(env, fi(env), ff, realIn, realOut, buffer)
  }

  @tailrec private def persistentWorkerLoop[S](
    env: Env,
    s: S,
    ff: (S, Options) => S,
    in: InputStream,
    out: PrintStream,
    buf: ByteArrayOutputStream
  ): Unit = {

    val request = WorkerProtocol.WorkRequest.parseDelimitedFrom(in)
    val clientArgs =  request.getArgumentsList.asScala.toList

    val (s0, code) =
      try {
        (ff(s, Options.read(clientArgs, env)), 0)
      } catch {
        case exit: AnxExitTrappedException => (s, exit.code)
        case e: Throwable =>
          println("The worker's task crashed!")
          e.printStackTrace()
          (s, -1)
      }

    WorkerProtocol.WorkResponse.newBuilder()
      .setOutput(buf.toString)
      .setExitCode(code)
      .build()
      .writeDelimitedTo(out)
    out.flush()

    buf.reset()

    persistentWorkerLoop(env, s0, ff, in, out, buf)
  }

}
