workspace(name = "blerg")

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


maven_jar(
    name = "scala_compiler_2_12_4",
    artifact = "org.scala-lang:scala-compiler:2.12.4",
)

maven_jar(
    name = "scala_library_2_12_4",
    artifact = "org.scala-lang:scala-library:2.12.4",
)

maven_jar(
    name = "scala_reflect_2_12_4",
    artifact = "org.scala-lang:scala-reflect:2.12.4",
)


maven_jar(
    name = "scala_compiler_2_11_9",
    artifact = "org.scala-lang:scala-compiler:2.11.9",
)

maven_jar(
    name = "scala_library_2_11_9",
    artifact = "org.scala-lang:scala-library:2.11.9",
)

maven_jar(
    name = "scala_reflect_2_11_9",
    artifact = "org.scala-lang:scala-reflect:2.11.9",
)


maven_jar(
    name = "compiler_bridge_2_12",
    artifact = "org.scala-sbt:compiler-bridge_2.12:1.1.1",
)

maven_jar(
    name = "compiler_bridge_2_11",
    artifact = "org.scala-sbt:compiler-bridge_2.11:1.1.1",
)

maven_jar(
    name = "compiler_interface",
    artifact = "org.scala-sbt:compiler-interface:1.1.1",
)

maven_jar(
    name = "util_interface",
    artifact = "org.scala-sbt:util-interface:1.1.1",
)

register_toolchains(
    '//annex:scala_2_11_9_toolchain',
    '//annex:scala_2_12_4_toolchain',
)
