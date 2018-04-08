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

#
# this is super sketchy but will work
# todo: refactor worker/runner interface
# so we can use the shared code as a proper lib
#
filegroup(
    name = "shared_sources",
    srcs = glob(["src/main/scala/**/*.scala"]),
    visibility = ["//visibility:public"],
)
