load("@rules_scala_annex//rules:scala.bzl", "annex_scala_binary", "annex_scala_library")

annex_scala_library(
    name = "library",
    srcs = ["Library.scala"],
    neverlink = True,
    scala = "@scala_2_12",
)

annex_scala_binary(
    name = "binary",
    srcs = ["Binary.scala"],
    scala = "@scala_2_12",
    deps = [":library"],
)
