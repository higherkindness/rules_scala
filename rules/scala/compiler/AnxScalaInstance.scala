package annex.compiler

import java.io.File
import java.net.URLClassLoader
import java.util.Properties
import xsbti.compile.ScalaInstance

final class AnxScalaInstance(val allJars: Array[File]) extends ScalaInstance {
  lazy val actualVersion = {
    val stream = loader.getResourceAsStream("compiler.properties")
    try {
      val props = new Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }

  def compilerJar = null

  lazy val libraryJar = allJars
    .find(f => new URLClassLoader(Array(f.toURI.toURL)).findResource("library.properties") != null)
    .get

  lazy val loader = new URLClassLoader(allJars.map(_.toURI.toURL), null)

  def loaderLibraryOnly = null

  def otherJars = null

  def version = actualVersion
}
