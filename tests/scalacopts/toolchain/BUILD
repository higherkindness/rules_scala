load("@rules_scala_annex//rules:scala.bzl", "scala_library", "scala_runner_toolchain")

scala_library(
    name = "lib",
    srcs = ["Deprecated.scala"],
    scala = "@typelevel_2_12",
)

scala_runner_toolchain(
    name = "fatal",
    runner = "@rules_scala_annex//rules/scala:zinc",
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

scala_runner_toolchain(
    name = "warn",
    runner = "@rules_scala_annex//rules/scala:zinc",
    scalacopts = [
        "-deprecation",
    ],
)
