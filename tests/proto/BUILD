load(
    "@rules_scala_annex//rules:scala_proto.bzl",
    "scala_proto_library",
)
load(
    "@rules_scala_annex//rules:scala.bzl",
    "scala_library",
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

scala_library(
    name = "zero_scala",
    srcs = [":zero_scala_proto"],
    deps = [
        "@com_google_protobuf_protobuf_java",
        "@com_thesamet_scalapb_lenses_2_12",
        "@com_thesamet_scalapb_scalapb_runtime_2_12",
    ]
)
