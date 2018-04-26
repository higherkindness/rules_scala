load("@rules_scala_annex//rules:scala.bzl", "annex_scala_library")

annex_scala_library(
    name = "default",
    srcs = ["Deprecated.scala"],
    scala = "@typelevel_2_12",
)

annex_scala_library(
    name = "fatal",
    srcs = ["Deprecated.scala"],
    scala = "@scala_2_12",
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

annex_scala_library(
    name = "warn",
    srcs = ["Deprecated.scala"],
    scala = "@typelevel_2_12",
    scalacopts = [
        "-deprecation",
    ],
)
