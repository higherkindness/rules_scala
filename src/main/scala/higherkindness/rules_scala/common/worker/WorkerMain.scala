package higherkindness.rules_scala
package common.worker

import com.google.devtools.build.lib.worker.WorkerProtocol
import java.io.{ByteArrayInputStream, ByteArrayOutputStream, OutputStream, PrintStream}
import java.security.Permission
import java.util.concurrent.ForkJoinPool
import scala.annotation.tailrec
import scala.concurrent.{ExecutionContext, Future}
import scala.util.{Failure, Success}

trait WorkerMain[S] {

  private[this] final case class ExitTrapped(code: Int) extends Throwable

  protected[this] def init(args: Option[Array[String]]): S

  protected[this] def work(ctx: S, args: Array[String], out: PrintStream): Unit

  final def main(args: Array[String]): Unit = {
    args.toList match {
      case "--persistent_worker" :: args =>
        val stdin = System.in
        val stdout = System.out
        val defaultSecurityManager = System.getSecurityManager
        val exceptionHandler = new Thread.UncaughtExceptionHandler {
          override def uncaughtException(t: Thread, err: Throwable): Unit = err match {
            case e: Throwable => {
              // Future catches all NonFatal errors, and wraps them in a Failure, so only Fatal errors get here.
              // If any request thread throws a Fatal error (OOM, StackOverflow, etc.), we can't trust the JVM, so log the error and exit.
              e.printStackTrace(System.err)
              System.setSecurityManager(defaultSecurityManager)
              System.exit(1)
            }
          }
        }
        val fjp = new ForkJoinPool(
          Runtime.getRuntime().availableProcessors(),
          ForkJoinPool.defaultForkJoinWorkerThreadFactory,
          exceptionHandler,
          false
        )
        implicit val ec = ExecutionContext.fromExecutor(fjp)

        System.setSecurityManager(new SecurityManager {
          val Exit = raw"exitVM\.(-?\d+)".r
          override def checkPermission(permission: Permission): Unit = {
            permission.getName match {
              case Exit(code) => throw new ExitTrapped(code.toInt)
              case _          =>
            }
          }
        })

        System.setIn(new ByteArrayInputStream(Array.emptyByteArray))
        System.setOut(System.err)

        def writeResponse(requestId: Int, outStream: OutputStream, code: Int) = {
          // Defined here so all writes to stdout are synchronized
          stdout.synchronized {
            WorkerProtocol.WorkResponse.newBuilder
              .setRequestId(requestId)
              .setOutput(outStream.toString)
              .setExitCode(code)
              .build
              .writeDelimitedTo(stdout)
          }
        }

        try {
          @tailrec
          def process(ctx: S): Unit = {
            val request = WorkerProtocol.WorkRequest.parseDelimitedFrom(stdin)
            if (request == null) {
              return
            }
            val args = request.getArgumentsList.toArray(Array.empty[String])

            val outStream = new ByteArrayOutputStream
            val out = new PrintStream(outStream)
            val requestId = request.getRequestId()
            System.out.println(s"WorkRequest $requestId received with args: ${request.getArgumentsList}")

            val f: Future[Int] = Future {
              try {
                work(ctx, args, out)
                0
              } catch {
                case ExitTrapped(code) => code
              }
            }

            f.onComplete {
              case Success(code) => {
                out.flush()
                writeResponse(requestId, outStream, code)
                System.out.println(s"WorkResponse $requestId sent with code $code")
              }
              case Failure(e) => {
                e.printStackTrace(out)
                out.flush()
                writeResponse(requestId, outStream, -1)
                System.err.println(s"Uncaught exception in Future while proccessing WorkRequest $requestId:")
                e.printStackTrace(System.err)
              }
            }
            process(ctx)
          }
          process(init(Some(args.toArray)))
        } finally {
          System.setIn(stdin)
          System.setOut(stdout)
        }

      case args => {
        val outStream = new ByteArrayOutputStream
        val out = new PrintStream(outStream)
        work(init(None), args.toArray, out)
      }
    }
  }
}
