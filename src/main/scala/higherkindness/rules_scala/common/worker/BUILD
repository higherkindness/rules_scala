load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "bootstrap_scala_library")

bootstrap_scala_library(
    name = "worker",
    srcs = glob(["**/*.scala"]),
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
