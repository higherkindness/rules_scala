load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "default",
    srcs = ["Deprecated.scala"],
    scala = "//scala:2_12",
)

scala_library(
    name = "fatal",
    srcs = ["Deprecated.scala"],
    scala = "//scala:2_12",
    scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
)

scala_library(
    name = "warn",
    srcs = ["Deprecated.scala"],
    scala = "//scala:2_12",
    scalacopts = [
        "-deprecation",
    ],
)

scala_library(
    name = "fatal_glob",
    srcs = ["Deprecated.scala"],
    scala = "//scala:zinc_2_12_6_fatal_deprecation_opt",
)
