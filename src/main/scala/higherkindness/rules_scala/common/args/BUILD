load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "scala_library")

scala_library(
    name = "args",
    srcs = glob(["**/*.scala"]),
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    deps = [
        "@maven//:net_sourceforge_argparse4j_argparse4j",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
