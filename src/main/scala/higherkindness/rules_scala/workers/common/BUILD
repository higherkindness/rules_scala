load("//rules:scala.bzl", "scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_library(
    name = "common",
    srcs = glob(["**/*.scala"]),
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "@annex//:net_sourceforge_argparse4j_argparse4j",
        "@annex//:org_scala_sbt_zinc_2_13",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
