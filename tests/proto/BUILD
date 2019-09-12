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
        "@annex_test//:com_google_protobuf_protobuf_java",
        "@annex_test//:com_thesamet_scalapb_lenses_2_12",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_2_12",
    ],
)

proto_library(
    name = "one_proto",
    srcs = ["one.proto"],
    deps = [
        ":zero_proto",
    ],
    visibility = ["//visibility:public"],
)

scala_proto_library(
    name = "one_scala_proto",
    deps = [
        ":one_proto",
    ],
)

scala_library(
    name = "one_scala",
    srcs = [":one_scala_proto"],
    deps = [
        ":zero_scala",
        "@annex_test//:com_google_protobuf_protobuf_java",
        "@annex_test//:com_thesamet_scalapb_lenses_2_12",
        "@annex_test//:com_thesamet_scalapb_scalapb_runtime_2_12",
    ],
)
