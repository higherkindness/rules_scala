load("//rules:scala.bzl", "bootstrap_scala_binary", "scala_binary")
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

bootstrap_scala_binary(
    name = "scalafmt",
    srcs = glob(["scalafmt/**/*.scala"]),
    main_class = "annex.scalafmt.ScalafmtRunner",
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [
        "//rules/common:worker",
        "@scalafmt_com_geirsson_metaconfig_core_2_12",
        "@scalafmt_com_geirsson_scalafmt_core_2_12",
        "@scalafmt_net_sourceforge_argparse4j_argparse4j",
        "@scalafmt_org_scalameta_parsers_2_12",
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
