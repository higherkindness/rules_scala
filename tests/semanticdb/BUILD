load("@rules_scala_annex//rules:scala.bzl", "configure_scala", "scala_library")
load(":rules.bzl", "my_plugin")

scala_library(
    name = "input",
    srcs = ["input.scala"],
    plugins = [
        "@rules_scala_annex//rules/semanticdb:2_12_7",
    ],
    scala = "@scala_2_12",
    tags = ["manual"],
)
