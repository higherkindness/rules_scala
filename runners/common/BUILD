load("//rules:build.bzl", "annex_scala_format_test", "annex_scala_runner_toolchain")
load(":build.bzl", "basic_scala_library")

annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)

annex_scala_runner_toolchain(
    name = "toolchain_implementation",
    runner = select({
        ":config_use_bloop": "@rules_scala_annex//runners/bloop:runner",
        "//conditions:default": "@rules_scala_annex//runners/zinc:runner",
    }),
    visibility = ["//visibility:public"],
)

toolchain(
    name = "configurable_runner_toolchain",
    toolchain = ":toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules:runner_toolchain_type",
    visibility = ["//visibility:public"],
)

config_setting(
    name = "config_use_bloop",
    values = {
        "define": "use_bloop=true",
    },
)

basic_scala_library(
    name = "common",
    srcs = glob(["src/main/scala/**/*.scala"]),
    scala = "@scalas//:scala_2_12_4",
    visibility = ["//visibility:public"],
    deps = [
        "//runners/worker",
    ],
)
