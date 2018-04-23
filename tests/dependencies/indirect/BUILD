load("@rules_scala_annex//rules:scala.bzl", "annex_scala_library")

annex_scala_library(
    name = "a",
    srcs = ["A.scala"],
    scala = "@scala_2_12",
)

annex_scala_library(
    name = "b",
    srcs = ["B.scala"],
    scala = "@scala_2_12",
    deps = [":a"],
)

annex_scala_library(
    name = "c",
    srcs = ["C.scala"],
    scala = "@scala_2_12",
    deps = [":b"],
)
