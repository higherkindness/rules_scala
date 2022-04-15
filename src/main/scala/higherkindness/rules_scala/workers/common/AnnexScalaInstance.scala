package higherkindness.rules_scala
package workers.common

import xsbti.compile.{CompilerInterface2, ScalaInstance}
import java.io.File
import java.net.URLClassLoader
import java.util.Properties

final class AnnexScalaInstance(override val allJars: Array[File]) extends ScalaInstance {
  // Some of these variable names don't really line up with what I imagine the
  // actual values should be. I'm following the examples I found from the Zinc source
  // and it seems to work well, so I'm sticking with it.
  // For reference: https://github.com/sbt/zinc/blob/1.5.x/internal/zinc-classpath/src/main/scala/sbt/internal/inc/ScalaInstance.scala
  override val compilerJars: Array[File] = allJars

  override val libraryJars: Array[File] = allJars
    .filter(f => new URLClassLoader(Array(f.toURI.toURL)).findResource("library.properties") != null)

  override val otherJars: Array[File] = allJars.diff(compilerJars ++ libraryJars)

  override val actualVersion: String = {
    val stream = new URLClassLoader(
      compilerJars.map(_.toURI.toURL),
      ClassLoader.getPlatformClassLoader()
    ).getResourceAsStream("compiler.properties")

    try {
      val props = new Properties
      props.load(stream)
      props.getProperty("version.number")
    } finally stream.close()
  }
  override val version: String = actualVersion

  override val loaderLibraryOnly: ClassLoader =
    new URLClassLoader(
      libraryJars.map(_.toURI.toURL),
      // The Scala 3 compiler jar has a dependency on the org.scala-sbt:compiler-interface jar.
      // Our ZincRunner code also has a dependency on the compiler-interface.
      //
      // This means we will end up in a situation with classes from the compiler-interface
      // being loaded by the classloader for the jvm that launched ZincRunner and also
      // the classloader that we're creating here for the Scala 3 compiler.
      //
      // This is a problem.
      //
      // An instance of a class in the JVM is defined by its fully qualified name
      // and classloader. Because the classloaders are different, we will get a
      // java.lang.LinkageError because the classloader for the ZincRunner will have already
      // loaded some compiler-interface classes that get used by the Scala 3 compiler during
      // its compilation run.
      //
      // To avoid this we are setting the parent of the Scala 3 compiler classloader, which
      // we are creating here, to the classloader for the jvm that launched the ZincRunner.
      // That avoids the LinkageError because URLClassLoaders go parent first, so it finds
      // the compiler-interface classes from the correct classloader.
      //
      // Problem is, doing this creates a potential leak: the parent classloader will be checked
      // for all classes used during the compilation. Meaning, any classes used in the
      // ZincRunner could end up leaking out into the Scala 3 compiler. So far this hasn't
      // caused any issues, but maybe it will in the future.
      //
      // Scala 2's compiler does not have the dependency on the compiler-interface, so it avoids
      // this problem.
      //
      // TODO: Fix this with classloader wizardry and witchcraft
      if (actualVersion.startsWith("3")) classOf[CompilerInterface2].getClassLoader else ClassLoader.getPlatformClassLoader()
    )

  override val loader: ClassLoader =
    new URLClassLoader(allJars.diff(libraryJars).map(_.toURI.toURL), loaderLibraryOnly)

  override val loaderCompilerOnly: ClassLoader = loader
}
