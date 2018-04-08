package annex

import bloop.Cli
import bloop.cli.{Commands, CliOptions}
import bloop.config.Config
import bloop.engine.{Run, NoPool}

import java.nio.file.{Paths, Path, Files}
import scala.collection.JavaConverters

object AnxRunner {
  def main(options: Options): Int = {
    val name = options.projectName
    val configFile = generateConfigFile(options)
    val opts = CliOptions.default.copy(configDir = Some(configFile.getParent))
    val action = Run(Commands.Compile(project = name, cliOptions = opts))
    Cli.run(action, NoPool, Array("bloop", "compile", name)).code
  }

  def generateConfigFile(options: Options): Path = {
    def toAbsolutePath(path: String): Path = Paths.get(path).toAbsolutePath
    val name = options.projectName
    val bloopConfig = toAbsolutePath(options.bloopConfig)
    val baseDir = toAbsolutePath(options.buildFilePath).getParent
    val sources = options.sources.map(toAbsolutePath(_)).toArray
    val dependencies = Array.empty[String] // No need for bloop to know the project graph
    val classpathOptions = Config.ClasspathOptions(true, false, false, true, true)

    // Add plugins options as the only scalac options for now
    val scalacOptions = options.pluginsClasspath.map(p => s"-Xplugin:${p}").toArray
    val classpath = options.compilationClasspath.map(toAbsolutePath(_)).toArray
    val target: Path = toAbsolutePath(options.targetDir)
    val classesDir = toAbsolutePath(options.outputDir)
    val scalaJars = options.compilerClasspath.map(toAbsolutePath(_)).toArray
    val `scala` = Config.Scala(
      organization = options.scalaOrganization,
      name = "scala-compiler",
      version = options.scalaVersion,
      options = scalacOptions,
      jars = scalaJars
    )

    val jvm = Config.Jvm(None, Array())
    val java = Config.Java(Array())
    val frameworks =
      options.testOptions.map(o => Config.TestFramework(o.frameworks)).toList.toArray
    val test = Config.Test(frameworks, Config.TestOptions(Nil, Nil))

    val project = Config.Project(
      name = name,
      directory = baseDir,
      sources = sources,
      dependencies = dependencies,
      classpath = classpath,
      classpathOptions = classpathOptions,
      out = target,
      classesDir = classesDir,
      `scala` = `scala`,
      jvm = jvm,
      java = java,
      test = test
    )

    val file = Config.File(Config.File.LatestVersion, project)
    Config.File.write(file, bloopConfig)
    bloopConfig
  }

}
