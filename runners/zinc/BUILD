load("//runners/common:build.bzl", "basic_scala_binary")

basic_scala_binary(
    name = "runner",
    srcs = glob(["src/main/scala/**/*.scala"]),
    main_class = "annex.ZincRunner",
    scala = "@scalas//:scala_2_12_4",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/org/scala_sbt:test_interface",
        "//3rdparty/jvm/org/scala_sbt:zinc",
        "//runners/common",
        "//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "//third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
    ],
)

load("//rules:build.bzl", "annex_scala_runner_toolchain")

annex_scala_runner_toolchain(
    name = "toolchain_implementation",
    runner = ":runner",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "runner_toolchain",
    toolchain = ":toolchain_implementation",
    toolchain_type = "//rules:runner_toolchain_type",
    visibility = ["//visibility:public"],
)
