load("//rules:scala.bzl", "scala_deps_toolchain", "scala_runner_toolchain")

toolchain(
    name = "bloop_toolchain",
    toolchain = ":bloop_toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules/scala:runner_toolchain_type",
    visibility = ["//visibility:public"],
)

scala_runner_toolchain(
    name = "bloop_toolchain_implementation",
    runner = ":bloop",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "config_runner_toolchain",
    toolchain = ":config_toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules/scala:runner_toolchain_type",
    visibility = ["//visibility:public"],
)

scala_runner_toolchain(
    name = "config_toolchain_implementation",
    encoding = "UTF-8",
    runner = select({
        ":config_use_bloop": "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/bloop/compile",
        "//conditions:default": "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/zinc/compile",
    }),
    visibility = ["//visibility:public"],
)

config_setting(
    name = "config_use_bloop",
    values = {
        "define": "use_bloop=true",
    },
)

toolchain_type(
    name = "runner_toolchain_type",
    visibility = ["//visibility:public"],
)

toolchain_type(
    name = "deps_toolchain_type",
    visibility = ["//visibility:public"],
)

config_setting(
    name = "config_deps_used_error",
    define_values = {
        "scala_deps_used": "error",
    },
)

config_setting(
    name = "config_deps_used_off",
    define_values = {
        "scala_deps_used": "off",
    },
)

config_setting(
    name = "config_deps_direct_error",
    define_values = {
        "scala_deps_direct": "error",
    },
)

config_setting(
    name = "config_deps_direct_off",
    define_values = {
        "scala_deps_direct": "off",
    },
)

scala_deps_toolchain(
    name = "config_deps_toolchain_implementation",
    direct = select({
        ":config_deps_direct_error": "error",
        ":config_deps_direct_off": "off",
        "//conditions:default": "check",
    }),
    runner = "//src/main/scala/higherkindness/rules_scala/workers/deps",
    used = select({
        ":config_deps_used_error": "error",
        ":config_deps_used_off": "off",
        "//conditions:default": "check",
    }),
    visibility = ["//visibility:public"],
)

toolchain(
    name = "config_deps_toolchain",
    toolchain = ":config_deps_toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules/scala:deps_toolchain_type",
    visibility = ["//visibility:public"],
)

scala_runner_toolchain(
    name = "zinc_toolchain_implementation",
    runner = ":zinc",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "zinc_runner_toolchain",
    toolchain = ":zinc_toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules/scala:runner_toolchain_type",
    visibility = ["//visibility:public"],
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)
