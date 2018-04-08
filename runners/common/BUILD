load("//rules:build.bzl", "annex_scala_runner_toolchain")

annex_scala_runner_toolchain(
    name = "toolchain_implementation",
    runner = select({
        ":config_use_bloop": "//runners/bloop:runner",
        "//conditions:default": "//runners/zinc:runner",
    }),
    visibility = ["//visibility:public"],
)

toolchain(
    name = "configurable_runner_toolchain",
    toolchain = ":toolchain_implementation",
    toolchain_type = "//rules:runner_toolchain_type",
    visibility = ["//visibility:public"],
)

config_setting(
    name = "config_use_bloop",
    values = {
        "define": "use_bloop=true",
    },
)
