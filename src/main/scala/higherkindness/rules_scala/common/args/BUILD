load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "bootstrap_scala_library")

bootstrap_scala_library(
    name = "args",
    srcs = glob(["**/*.scala"]),
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    deps = [
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
