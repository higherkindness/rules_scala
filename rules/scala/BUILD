load("//rules:scala.bzl", "annex_scala_library", "annex_scala_binary", "annex_scala_deps_toolchain", "annex_scala_runner_toolchain")
load("//rules:scalac.bzl", "scalac_binary", "scalac_library")
load("//rules:scalafmt.bzl", "annex_scala_format_test")

# Bloop

scalac_binary(
    name = "bloop",
    srcs = glob(["bloop/**/*.scala"]),
    main_class = "annex.BloopRunner",
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        ":compiler",
        "//rules/common:worker",
        "//rules/common/third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "@scala_annex_ch_epfl_scala_bloop_frontend_2_12",
        "@scala_annex_org_scala_sbt_test_interface",
    ],
)

toolchain(
    name = "bloop_toolchain",
    toolchain = ":bloop_toolchain_implementation",
    toolchain_type = "@rules_scala_annex//rules/scala:runner_toolchain_type",
    visibility = ["//visibility:public"],
)

annex_scala_runner_toolchain(
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

annex_scala_runner_toolchain(
    name = "config_toolchain_implementation",
    runner = select({
        ":config_use_bloop": "@rules_scala_annex//rules/scala:bloop",
        "//conditions:default": "@rules_scala_annex//rules/scala:zinc",
    }),
    visibility = ["//visibility:public"],
)

config_setting(
    name = "config_use_bloop",
    values = {
        "define": "use_bloop=true",
    },
)

scalac_library(
    name = "compiler",
    srcs = glob(["compiler/**/*.scala"]),
    scala = "//external:scala_annex_scala_basic",
    deps = [
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
    ],
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

annex_scala_deps_toolchain(
    name = "config_deps_toolchain_implementation",
    direct = select({
        ":config_deps_direct_error": "error",
        ":config_deps_direct_off": "off",
        "//conditions:default": "check",
    }),
    runner = ":deps",
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

scalac_binary(
    name = "deps",
    srcs = glob(["deps/**/*.scala"]),
    main_class = "annex.deps.DepsRunner",
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    deps = [
        "//rules/common:worker",
        "@scala_annex_net_sourceforge_argparse4j_argparse4j",
    ],
)

# Test

annex_scala_binary(
    name = "test",
    srcs = glob(["test/**/*.scala"]),
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [
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

proto_library(
    name = "zinc_options_proto",
    srcs = glob(["zinc/**/*.proto"]),
)

java_proto_library(
    name = "zinc_options_proto_java",
    deps = [":zinc_options_proto"],
)

scalac_binary(
    name = "zinc",
    srcs = glob(["zinc/**/*.scala"]),
    main_class = "annex.zinc.ZincRunner",
    scala = "//external:scala_annex_scala_basic",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@scala_annex_com_lihaoyi_sourcecode_2_12",
    ],
    deps = [
        ":compiler",
        "//rules/common:worker",
        "//rules/common/third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "@scala_annex_org_scala_sbt_test_interface",
        "@scala_annex_org_scala_sbt_zinc_2_12",
    ],
)

annex_scala_runner_toolchain(
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

annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
