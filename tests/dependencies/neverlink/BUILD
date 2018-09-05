load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "library",
    srcs = ["Library.scala"],
    neverlink = True,
    scala = "@scala_2_12",
)

scala_binary(
    name = "binary",
    srcs = ["Binary.scala"],
    scala = "@scala_2_12",
    deps = [":library"],
)
