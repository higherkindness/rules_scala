package higherkindness.rules_scala
package common.worker

import com.google.devtools.build.lib.worker.WorkerProtocol
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.InputStream
import java.io.PrintStream
import java.lang.SecurityManager
import java.security.Permission
import scala.annotation.tailrec
import scala.util.control.NonFatal

trait WorkerMain[S] {

  private[this] final case class ExitTrapped(code: Int) extends Throwable

  protected[this] def init(args: Option[Array[String]]): S

  protected[this] def work(ctx: S, args: Array[String]): Unit

  final def main(args: Array[String]): Unit = {
    args.toList match {
      case "--persistent_worker" :: args =>
        val stdin = System.in
        val stdout = System.out
        val stderr = System.err

        System.setSecurityManager(new SecurityManager {
          val Exit = raw"exitVM\.(-?\d+)".r
          override def checkPermission(permission: Permission): Unit = {
            permission.getName match {
              case Exit(code) => throw new ExitTrapped(code.toInt)
              case _          =>
            }
          }
        })

        val outStream = new ByteArrayOutputStream
        val out = new PrintStream(outStream)

        System.setIn(new ByteArrayInputStream(Array.emptyByteArray))
        System.setOut(out)
        System.setErr(out)

        try {
          @tailrec
          def process(ctx: S): S = {
            val request = WorkerProtocol.WorkRequest.parseDelimitedFrom(stdin)
            val args = request.getArgumentsList.toArray(Array.empty[String])

            val code =
              try {
                work(ctx, args)
                0
              } catch {
                case ExitTrapped(code) => code
                case NonFatal(e) =>
                  e.printStackTrace()
                  1
              }

            WorkerProtocol.WorkResponse.newBuilder
              .setOutput(outStream.toString)
              .setExitCode(code)
              .build
              .writeDelimitedTo(stdout)

            out.flush()
            outStream.reset()

            process(ctx)
          }
          process(init(Some(args.toArray)))
        } finally {
          System.setIn(stdin)
          System.setOut(stdout)
          System.setErr(stderr)
        }

      case args => work(init(None), args.toArray)
    }
  }

}
