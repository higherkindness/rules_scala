load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "default",
    srcs = ["Deprecated.scala"],
    scala = "@typelevel_2_12",
)

scala_library(
    name = "fatal",
    srcs = ["Deprecated.scala"],
    scala = "@scala_2_12",
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

scala_library(
    name = "warn",
    srcs = ["Deprecated.scala"],
    scala = "@typelevel_2_12",
    scalacopts = [
        "-deprecation",
    ],
)
