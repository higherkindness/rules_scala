load("//runners/common:build.bzl", "basic_scala_binary")

basic_scala_binary(
    name = "runner",
    srcs = glob(["src/main/scala/**/*.scala"]),
    main_class = "annex.BloopRunner",
    scala = "@scalas//:scala_2_12_4",
    visibility = ["//visibility:public"],
    deps = [
        "//runners/common",
        "//3rdparty/jvm/org/scala_sbt:test_interface",
        "//3rdparty/jvm/ch/epfl/scala:bloop_frontend",
        "//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",        
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
