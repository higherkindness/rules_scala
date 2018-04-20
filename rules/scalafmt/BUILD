load("//rules:scala.bzl", "annex_scala_binary")
load("//rules:scalafmt.bzl", "annex_scala_format_test")

filegroup(
    name = "runner",
    srcs = ["private/format.template.sh"],
    visibility = ["//visibility:public"],
)

annex_scala_binary(
    name = "scalafmt",
    srcs = glob(["scalafmt/**/*.scala"]),
    main_class = "annex.scalafmt.ScalamftRunner",
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [
        "//rules/common:worker",
        "@scalafmt_com_geirsson_metaconfig_core_2_12",
        "@scalafmt_com_geirsson_scalafmt_core_2_12",
        "@scalafmt_net_sourceforge_argparse4j_argparse4j",
    ],
)

annex_scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
