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
    scala = "@scala_annex_scala_2_12",
    visibility = ["//visibility:public"],
    deps = [
        "//rules/common:args",
        "//rules/common:worker",
        "//rules/common/third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
        "@scala_proto_com_github_os72_protoc_jar",
        "@scala_proto_com_thesamet_scalapb_compilerplugin_2_12",
        "@scala_proto_com_thesamet_scalapb_protoc_bridge_2_12",
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
