load("//rules:scalafmt.bzl", "scala_format_test")
load("//rules:scala.bzl", "scala_library")

_subprocess_srcs = glob(["SubprocessRunner.scala"])

_common_srcs = [
    f
    for f in glob(["**/*.scala"])
    if f not in _subprocess_srcs
]

scala_library(
    name = "subprocess",
    srcs = _subprocess_srcs,
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [
        ":common",
        "@scala_annex_org_scala_sbt_test_interface",
    ],
)

scala_library(
    name = "common",
    srcs = _common_srcs,
    scala = "//external:scala_annex_scala",
    visibility = ["//visibility:public"],
    deps = [
        "@scala_annex_org_scala_sbt_test_interface",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
