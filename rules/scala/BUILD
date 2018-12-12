load("//rules:scala.bzl", "bootstrap_scala_binary", "bootstrap_scala_library", "scala_binary", "scala_deps_toolchain", "scala_library", "scala_runner_toolchain")
load("//rules:scalafmt.bzl", "scala_format_test")

# Bloop

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

# Common

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

# Deps

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

# Test

scala_library(
    name = "test",
    srcs = glob(["test/**/*.scala"]),
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/args",
        "//src/main/scala/higherkindness/rules_scala/common/sbt-testing:common",
        "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
        "@scala_annex_org_scala_sbt_compiler_interface",
        "@scala_annex_org_scala_sbt_test_interface",
        "@scala_annex_org_scala_sbt_zinc_apiinfo_2_12",
        "@scala_annex_org_scala_sbt_zinc_core_2_12",
        "@scala_annex_org_scala_sbt_zinc_persist_2_12",
    ],
)

# Zinc

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

# Other

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
