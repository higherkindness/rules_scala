load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "plain",
    resources = glob(["reference.conf"]),
    resource_strip_prefix = "resources/reference_conf",
    scala = "//scala:2_11",
)

java_library(
    name = "plain_java",
    resources = glob(["reference.conf"]),
    resource_strip_prefix = "resources/reference_conf",
)
