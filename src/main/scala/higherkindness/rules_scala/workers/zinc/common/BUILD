load("//rules:scala.bzl", "bootstrap_scala_library")
load("//rules:scalafmt.bzl", "scala_format_test")

bootstrap_scala_library(
    name = "common",
    srcs = glob(["**/*.scala"]),
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
        "@scala_annex_org_scala_sbt_zinc_2_12",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
