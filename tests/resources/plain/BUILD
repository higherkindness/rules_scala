load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "plain",
    resources = glob(["**/*.txt"]),
    scala = "//scala:2_13",
)

scala_library(
    name = "merged",
    resource_jars = [":plain"],
    resource_strip_prefix = "resources",
    resources = glob(["**/*.txt"]),
    scala = "//scala:2_13",
)
