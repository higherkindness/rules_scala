workspace(name = "scala_annex")

load("//rules:internal/utils.bzl", "require_bazel_version")

require_bazel_version("0.11.0")

http_archive(
    name = "com_google_protobuf",
    sha256 = "7404d040865a031e80c2810cd9453eafefb2bbbf5f5f9a282b1d071d8e12c4bf",
    strip_prefix = "protobuf-3.5.2",
    urls = ["https://github.com/google/protobuf/archive/v3.5.2.zip"],
)

load("//3rdparty:workspace.bzl", "maven_dependencies")

maven_dependencies()

load("//rules:workspace.bzl", "annex_scala_repositories")

register_toolchains("//runners/common:configurable_runner_toolchain")

annex_scala_repositories(
    name = "scalas",
    versions = {
        "scala": [
            "org.scala-lang:2.10.3",
            "org.scala-lang:2.10.4",
            "org.scala-lang:2.10.5",
            "org.scala-lang:2.10.6",
            "org.scala-lang:2.10.7",
            "org.scala-lang:2.11.0",
            "org.scala-lang:2.11.1",
            "org.scala-lang:2.11.2",
            "org.scala-lang:2.11.3",
            "org.scala-lang:2.11.4",
            "org.scala-lang:2.11.5",
            "org.scala-lang:2.11.6",
            "org.scala-lang:2.11.7",
            "org.scala-lang:2.11.8",
            "org.scala-lang:2.11.9",
            "org.scala-lang:2.11.10",
            "org.scala-lang:2.11.11",
            "org.scala-lang:2.11.12",
            "org.scala-lang:2.12.0",
            "org.scala-lang:2.12.1",
            "org.scala-lang:2.12.2",
            "org.scala-lang:2.12.3",
            "org.scala-lang:2.12.4",
        ],
        "typelevel_scala": [
            "org.typelevel:2.11.7",
            "org.typelevel:2.11.8",
            "org.typelevel:2.11.11-bin-typelevel-4",
            "org.typelevel:2.12.0",
            "org.typelevel:2.12.1",
            "org.typelevel:2.12.2-bin-typelevel-4",
            "org.typelevel:2.12.3-bin-typelevel-4",
            "org.typelevel:2.12.4-bin-typelevel-4",
        ],
        #'dotty': [
        #    'ch.epfl.lamp:0.7.0-RC1',
        #],
    },
)

maven_jar(
    name = "compiler_bridge_2_10",
    artifact = "org.scala-sbt:compiler-bridge_2.11:1.1.3",
)

maven_jar(
    name = "compiler_bridge_2_11",
    artifact = "org.scala-sbt:compiler-bridge_2.11:1.1.3",
)

maven_jar(
    name = "compiler_bridge_2_12",
    artifact = "org.scala-sbt:compiler-bridge_2.12:1.1.3",
)

maven_jar(
    name = "compiler_interface",
    artifact = "org.scala-sbt:compiler-interface:1.1.3",
)

maven_jar(
    name = "util_interface",
    artifact = "org.scala-sbt:util-interface:1.1.3",
)

maven_jar(
    name = "zinc_2_12",
    artifact = "org.scala-sbt:zinc_2.12:1.1.3",
)

# currently used in tests

maven_jar(
    name = "kind_projector_2_11",
    artifact = "org.spire-math:kind-projector_2.12:0.9.6",
)

maven_jar(
    name = "kind_projector_2_12",
    artifact = "org.spire-math:kind-projector_2.12:0.9.6",
)
