load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

filegroup(
    name = "runner",
    srcs = ["private/format.template.sh"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "testrunner",
    srcs = ["private/format-test.template.sh"],
    visibility = ["//visibility:public"],
)

scala_binary(
    name = "scalafmt",
    srcs = glob(["scalafmt/**/*.scala"]),
    main_class = "annex.scalafmt.ScalafmtRunner",
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "//src/main/scala/higherkindness/rules_scala/workers/common",
        "@annex//:net_sourceforge_argparse4j_argparse4j",
        "@annex_scalafmt//:com_geirsson_metaconfig_core_2_13",
        "@annex_scalafmt//:org_scalameta_parsers_2_13",
        "@annex_scalafmt//:org_scalameta_scalafmt_core_2_13",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)

filegroup(
    name = "bzl",
    srcs = glob(["**/*.bzl"]),
    visibility = ["//rules:__pkg__"],
)

load(
    ":ext.bzl",
    _add_non_default_format_phase_singleton = "add_non_default_format_phase_singleton",
)

_add_non_default_format_phase_singleton(
    name = "add_non_default_format_phase",
    visibility = ["//visibility:public"],
)
