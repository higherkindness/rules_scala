package annex

final case class Env(
  isWorker: Boolean,
  extraFlags: List[String]
)

object Env {
  def read(args: Option[Seq[String]]) = args.fold(Env(false, Nil))(args => Env(true, args.toList))
}

final case class TestOptions(
  frameworks: List[String]
)

final case class Options(
  verbose: Boolean,
  persistenceDir: Option[String],
  outputJar: String,
  outputDir: String,
  scalaVersion: String,
  compilerClasspath: List[String],
  compilerBridge: String,
  pluginsClasspath: List[String],
  sources: List[String],
  compilationClasspath: List[String],
  allowedClasspath: List[String],
  label: String,
  analysisPath: String,
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
      |  analysisPath        : $analysisPath""".stripMargin
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

  private def readOption[A](f: State[List[String], A]): State[List[String], Option[A]] =
    readBoolean.flatMap(
      hasIt =>
        if (hasIt) f.map(Some(_))
        else State.pure(None)
    )

  private val readTestOptions: State[List[String], TestOptions] =
    for {
      frameworks <- readStringList
    } yield TestOptions(frameworks)

  private val readOptions: State[List[String], Options] =
    for {
      verbose <- readBoolean
      persistenceDir <- readString
      outputJar <- readString
      outputDir <- readString
      scalaVersion <- readString
      compilerClasspath <- readStringList
      compilerBridge <- readString
      pluginsClasspath <- readStringList
      sources <- readStringList
      compilationClasspath <- readStringList
      allowedClasspath <- readStringList
      label <- readString
      analysisPath <- readString
    } yield {
      // TODO: why do quotes appear?
      val realPersistenceDir = persistenceDir.replace("'", "")
      Options(
        verbose,
        if (realPersistenceDir.nonEmpty) Some(realPersistenceDir) else None,
        outputJar,
        outputDir,
        scalaVersion,
        compilerClasspath,
        compilerBridge,
        pluginsClasspath,
        sources,
        compilationClasspath,
        allowedClasspath,
        label.tail,
        analysisPath
      )
    }

  def read(args: List[String], env: Env): Options = {
    val options = {
      val original = readOptions.run(args)._2
      val verbose = if (env.extraFlags.contains("--verbose")) Some(true) else None
      val persistenceDir =
        env.extraFlags.map(_.split("=", 2)).collectFirst { case Array("--persistenceDir", dir) => Some(dir) }
      original.copy(
        verbose = verbose.getOrElse(original.verbose),
        persistenceDir = persistenceDir.getOrElse(original.persistenceDir)
      )
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

// tiny state monad

final case class State[S, A](run: S => (S, A)) {

  def map[B](f: A => B): State[S, B] =
    new State(s => {
      val res = run(s)
      (res._1, f(res._2))
    })

  def flatMap[B](f: A => State[S, B]): State[S, B] =
    new State(s => {
      val res = run(s)
      f(res._2).run(res._1)
    })

}

object State {
  def pure[S, A](a: A): State[S, A] = State(s => (s, a))
}
