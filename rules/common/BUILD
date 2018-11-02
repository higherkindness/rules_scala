load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scalac.bzl", "scalac_library")

scalac_library(
    name = "args",
    srcs = glob(["args/**/*.scala"]),
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
    ],
)

scalac_library(
    name = "worker",
    srcs = glob(["worker/**/*.scala"]),
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        "//rules/common/third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)
