load("//rules:build.bzl", "annex_scala_format_test")
load("//runners/common:build.bzl", "basic_scala_library")

basic_scala_library(
    name = "worker",
    srcs = glob(["src/main/scala/**/*.scala"]),
    scala = "@scalas//:scala_2_12_4",
    visibility = ["//visibility:public"],
    deps = [
        "//third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
    ],
)

annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
