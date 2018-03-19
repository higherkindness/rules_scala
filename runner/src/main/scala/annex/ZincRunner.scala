package annex

object ZincRunner {
  def main(args: Array[String]): Unit = {
    println("annex zinc runner")
  }
}

import java.io.File
import java.net.URLClassLoader;
import java.util.function.Supplier;

final case class ScalaInstance(
  version: String,
  allJars: Array[File]
) extends xsbti.compile.ScalaInstance {

  lazy val loader: ClassLoader =
    new URLClassLoader(allJars.map(_.toURI.toURL))

  lazy val actualVersion: String = {
    val stream = loader.getResourceAsStream("compiler.properties")
    try {
      val props = new java.util.Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  private[this] def unused: Nothing = sys.error("deprecated/unused")

  def libraryJar: File = unused
  def compilerJar: File = unused
  def otherJars: Array[File] = unused
}

final class Logger extends xsbti.Logger {

  def error(msg: Supplier[String]): Unit =
    println(s"[error]: ${msg.get}")

  def warn(msg: Supplier[String]): Unit =
    println(s"[warn ]: ${msg.get}")

  def info(msg: Supplier[String]): Unit =
    println(s"[info ]: ${msg.get}")

  def debug(msg: Supplier[String]): Unit =
    println(s"[debug]: ${msg.get}")

  def trace(err: Supplier[Throwable]): Unit =
    println(s"[trace]: ${err.get.getMessage}")

}
