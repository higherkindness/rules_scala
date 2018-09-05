load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "prefix",
    resource_strip_prefix = package_name(),
    resources = glob(["**/*.txt"]),
    scala = "@scala_2_11",
)

scala_library(
    name = "outside",
    resource_strip_prefix = "{}/other".format(package_name()),
    resources = glob(["**/*.txt"]),
    scala = "@scala_2_11",
)
