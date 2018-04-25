load("//rules:scalafmt.bzl", "annex_scala_format_test")
load("//rules:scalac.bzl", "scalac_library")

scalac_library(
    name = "worker",
    srcs = glob(["worker/**/*.scala"]),
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        "//rules/common/third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
    ],
)

annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
