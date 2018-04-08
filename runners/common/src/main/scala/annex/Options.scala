package annex

final case class TestOptions(
    frameworks: List[String]
)

final case class Options(
    verbose: Boolean,
    outputJar: String,
    outputDir: String,
    scalaVersion: String,
    compilerClasspath: List[String],
    compilerBridge: String,
    pluginsClasspath: List[String],
    sources: List[String],
    compilationClasspath: List[String],
    allowedClasspath: List[String],
    testOptions: Option[TestOptions]
)

object Options {
  private def renderList(items: List[String]): String =
    if (items.isEmpty) "Nil"
    else "List(\n    " + items.mkString("\n    ") + ")"

  private def render(options: Options): String = {
    import options._
    s"""|options:
      |  verbose             : $verbose,
      |  outputJar           : $outputJar,
      |  outputDir           : $outputDir,
      |  scalaVersion        : $scalaVersion,
      |  compilerClasspath   : ${renderList(compilerClasspath)},
      |  compilerBridge      : $compilerBridge,
      |  pluginsClasspath    : ${renderList(pluginsClasspath)},
      |  sources             : ${renderList(sources)},
      |  compilationClasspath: ${renderList(compilationClasspath)},
      |  allowedClasspath    : ${renderList(allowedClasspath)},
      |  testOptions         : $testOptions""".stripMargin
  }

  private val readString: State[List[String], String] =
    State(_ match {
      case head :: tail => (tail, head)
      case _            => ???
    })

  private val readBoolean: State[List[String], Boolean] =
    readString.map(_.toBoolean)

  private val readStringList: State[List[String], List[String]] =
    State(_ match {
      case n :: tail => tail.splitAt(n.toInt).swap
      case _         => ???
    })

  private def readOption[A](
      f: State[List[String], A]): State[List[String], Option[A]] =
    readBoolean.flatMap(
      hasIt =>
        if (hasIt) f.map(Some(_))
        else State.pure(None))

  private val readTestOptions: State[List[String], TestOptions] =
    for {
      frameworks <- readStringList
    } yield TestOptions(frameworks)

  private val readOptions: State[List[String], Options] =
    for {
      verbose <- readBoolean
      outputJar <- readString
      outputDir <- readString
      scalaVersion <- readString
      compilerClasspath <- readStringList
      compilerBridge <- readString
      pluginsClasspath <- readStringList
      sources <- readStringList
      compilationClasspath <- readStringList
      allowedClasspath <- readStringList
      testOptions <- readOption(readTestOptions)
    } yield
      Options(verbose,
              outputJar,
              outputDir,
              scalaVersion,
              compilerClasspath,
              compilerBridge,
              pluginsClasspath,
              sources,
              compilationClasspath,
              allowedClasspath,
              testOptions)

  def read(args: List[String], env: AnxWorker.Env): Options = {
    val options = {
      val original = readOptions.run(args)._2
      if (env.extraFlags.contains("--verbose"))
        original.copy(verbose = true)
      else
        original
    }
    if (options.verbose) {
      println("env:")
      println(s"  isWorker            : ${env.isWorker}")
      println(s"  extraFlags          : ${renderList(env.extraFlags)}")
      println(render(options))
    }
    options
  }
}
