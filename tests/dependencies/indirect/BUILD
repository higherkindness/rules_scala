load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "a",
    srcs = ["A.scala"],
    scala = "//scala:2_12",
)

scala_library(
    name = "b",
    srcs = ["B.scala"],
    scala = "//scala:2_12",
    deps = [":a"],
)

scala_library(
    name = "c",
    srcs = ["C.scala"],
    scala = "//scala:2_12",
    deps = [":b"],
)
