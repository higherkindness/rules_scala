workspace(name = "scala_annex")

rules_scala_version="24bc74b2664560fdba27b31da9e6c529dd231e1e"

http_archive(
    name = "io_bazel_rules_scala",
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_version,
    type = "zip",
    strip_prefix = "rules_scala-%s" % rules_scala_version
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories()

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

load("//3rdparty:workspace.bzl", "maven_dependencies")
maven_dependencies()


load("//rules:workspace.bzl", "annex_configure_scala")
annex_configure_scala(
    name = 'scalas',
    versions = {
        'scala': [
            'org.scala-lang:2.10.3',
            'org.scala-lang:2.10.4',
            'org.scala-lang:2.10.5',
            'org.scala-lang:2.10.6',
            'org.scala-lang:2.10.7',

            'org.scala-lang:2.11.0',
            'org.scala-lang:2.11.1',
            'org.scala-lang:2.11.2',
            'org.scala-lang:2.11.3',
            'org.scala-lang:2.11.4',
            'org.scala-lang:2.11.5',
            'org.scala-lang:2.11.6',
            'org.scala-lang:2.11.7',
            'org.scala-lang:2.11.8',
            'org.scala-lang:2.11.9',
            'org.scala-lang:2.11.10',
            'org.scala-lang:2.11.11',
            'org.scala-lang:2.11.12',

            'org.scala-lang:2.12.0',
            'org.scala-lang:2.12.1',
            'org.scala-lang:2.12.2',
            'org.scala-lang:2.12.3',
            'org.scala-lang:2.12.4',
        ],
        'typelevel_scala': [
            'org.typelevel:2.11.7',
            'org.typelevel:2.11.8',
            'org.typelevel:2.11.11-bin-typelevel-4',

            'org.typelevel:2.12.0',
            'org.typelevel:2.12.1',
            'org.typelevel:2.12.2-bin-typelevel-4',
            'org.typelevel:2.12.3-bin-typelevel-4',
            'org.typelevel:2.12.4-bin-typelevel-4',
        ],
        #'dotty': [
        #    'ch.epfl.lamp:0.7.0-RC1',
        #],
    },
)

maven_jar(
    name = "compiler_bridge_2_10",
    artifact = "org.scala-sbt:compiler-bridge_2.11:1.1.1",
)

maven_jar(
    name = "compiler_bridge_2_11",
    artifact = "org.scala-sbt:compiler-bridge_2.11:1.1.1",
)

maven_jar(
    name = "compiler_bridge_2_12",
    artifact = "org.scala-sbt:compiler-bridge_2.12:1.1.1",
)

maven_jar(
    name = "compiler_interface",
    artifact = "org.scala-sbt:compiler-interface:1.1.1",
)

maven_jar(
    name = "util_interface",
    artifact = "org.scala-sbt:util-interface:1.1.1",
)

maven_jar(
    name = "zinc_2_12",
    artifact = "org.scala-sbt:zinc_2.12:1.1.1",
)
