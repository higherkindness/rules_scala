load("@rules_scala_annex//rules:scala.bzl", "annex_scala_library", "annex_scala_runner_toolchain")

annex_scala_library(
    name = "lib",
    srcs = ["Deprecated.scala"],
    scala = "@typelevel_2_12",
)

annex_scala_runner_toolchain(
    name = "fatal",
    runner = "@rules_scala_annex//rules/scala:zinc",
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

annex_scala_runner_toolchain(
    name = "warn",
    runner = "@rules_scala_annex//rules/scala:zinc",
    scalacopts = [
        "-deprecation",
    ],
)
