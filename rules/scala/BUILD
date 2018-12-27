load("//rules:scala.bzl", "scala_deps_toolchain")

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

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)
