load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "plain",
    resource_strip_prefix = "resources/reference_conf",
    resources = ["reference.conf"],
    scala = "//scala:2_13",
)

java_library(
    name = "plain_java",
    resource_strip_prefix = "resources/reference_conf",
    resources = ["reference.conf"],
)
