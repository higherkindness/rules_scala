load(
    "@rules_scala_annex//rules:scala_proto.bzl",
    "scala_proto_library",
)
load(
    "@rules_scala_annex//rules:scala.bzl",
    "annex_scala_library",
)

proto_library(
    name = "zero_proto",
    srcs = ["zero.proto"],
    visibility = ["//visibility:public"],
)

scala_proto_library(
    name = "zero_scala_proto",
    deps = [":zero_proto"],
)

annex_scala_library(
    name = "zero_scala",
    deps = [":zero_scala_proto"],
)
