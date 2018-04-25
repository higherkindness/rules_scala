load("@rules_scala_annex//rules:scala.bzl", "annex_scala_library")

annex_scala_library(
    name = "plain",
    resources = glob(["**/*.txt"]),
    scala = "@scala_2_11",
)

annex_scala_library(
    name = "merged",
    resource_jars = [":plain"],
    resource_strip_prefix = "resources",
    resources = glob(["**/*.txt"]),
    scala = "@scala_2_11",
)
