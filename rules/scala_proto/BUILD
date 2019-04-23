load(
    "//rules:scala.bzl",
    "scala_binary",
)
load(
    "//rules:scala_proto.bzl",
    "scala_proto_toolchain",
)

toolchain_type(
    name = "compiler_toolchain_type",
    visibility = ["//visibility:public"],
)

scala_binary(
    name = "worker",
    srcs = glob(["private/ScalaProtoWorker.scala"]),
    main_class = "annex.scala.proto.ScalaProtoWorker",
    scala = "//src/main/scala:zinc",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "@annex//:net_sourceforge_argparse4j_argparse4j",
        "@annex_proto//:com_github_os72_protoc_jar",
        "@annex_proto//:com_thesamet_scalapb_compilerplugin_2_12",
        "@annex_proto//:com_thesamet_scalapb_protoc_bridge_2_12",
    ],
)

scala_proto_toolchain(
    name = "scalapb_scala_proto_toolchain_implementation",
    compiler = ":worker",
    compiler_supports_workers = True,
    visibility = ["//visibility:public"],
)

toolchain(
    name = "scalapb_scala_proto_toolchain",
    toolchain = ":scalapb_scala_proto_toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules/scala_proto:compiler_toolchain_type",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)
