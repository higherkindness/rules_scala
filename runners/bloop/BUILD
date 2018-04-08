load("//runners/common:build.bzl", "basic_scala_binary")

basic_scala_binary(
    name = "runner",
    srcs =
        glob(["src/main/scala/**/*.scala"]) + [
            "//runners/common:shared_sources",
        ],
    main_class = "annex.AnxWorker",
    scala = "@scalas//:scala_2_12_4",
    visibility = ["//visibility:public"],
    deps = [
        "//3rdparty/jvm/org/scala_sbt:compiler_interface",
        "//3rdparty/jvm/org/scala_sbt:test_interface",
        "//3rdparty/jvm/org/scala_sbt:util_control_2_12",
        "//3rdparty/jvm/org/scala_sbt:util_interface",
        "//3rdparty/jvm/org/scala_sbt:util_logging_2_12",
        "//3rdparty/jvm/org/scala_sbt:zinc_2_12",
        "//3rdparty/jvm/org/scala_sbt:zinc_apiinfo_2_12",
        "//3rdparty/jvm/org/scala_sbt:zinc_compile_core_2_12",
        "//3rdparty/jvm/org/scala_sbt:zinc_core_2_12",
        "//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "//third_party/bazel/src/main/protobuf:worker_protocol_java_proto",
        "//3rdparty/jvm/ch/epfl/scala:bloop_frontend",
        "//3rdparty/jvm/ch/epfl/scala:bloop_backend",
        "//3rdparty/jvm/ch/epfl/scala:bloop_config",
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
