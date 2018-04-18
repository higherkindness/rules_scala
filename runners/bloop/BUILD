load("//runners/common:build.bzl", "basic_scala_binary")

basic_scala_binary(
    name = "runner",
    srcs = glob(["src/main/scala/**/*.scala"]),
    main_class = "annex.BloopRunner",
    scala = "@scalas//:scala_2_12_4",
    visibility = ["//visibility:public"],
    deps = [
        "//runners/common",
        "//runners/worker",
        "//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "@scala_annex_ch_epfl_scala_bloop_frontend_2_12",
        "@scala_annex_org_scala_sbt_test_interface",
    ],
)

load("//rules:build.bzl", "annex_scala_format_test", "annex_scala_runner_toolchain")

annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)

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
