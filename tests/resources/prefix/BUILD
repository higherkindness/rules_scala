load("@rules_scala_annex//rules:scala.bzl", "annex_scala_library")

annex_scala_library(
    name = "prefix",
    resource_strip_prefix = package_name(),
    resources = glob(["**/*.txt"]),
    scala = "@scala_2_11",
)

annex_scala_library(
    name = "outside",
    resource_strip_prefix = "{}/other".format(package_name()),
    resources = glob(["**/*.txt"]),
    scala = "@scala_2_11",
)
