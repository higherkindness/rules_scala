load("@io_bazel_rules_scala//scala:scala.bzl", "scala_library")

scala_library(
    name = "default",
    srcs = ["Deprecated.scala"],
)

scala_library(
    name = "fatal",
    srcs = ["Deprecated.scala"],
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

scala_library(
    name = "warn",
    srcs = ["Deprecated.scala"],
    scalacopts = [
        "-deprecation",
    ],
)
