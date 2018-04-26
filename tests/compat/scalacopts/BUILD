load("@rules_scala_annex//rules/scala:compat.bzl", "scala_library")

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
