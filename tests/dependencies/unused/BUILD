load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala = "@scala_2_12"

scala_library(
    name = "0_used",
    srcs = ["0_used.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
    ],
)

scala_library(
    name = "0_unused",
    srcs = ["0_unused.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
    ],
)

scala_library(
    name = "indirect_unused",
    srcs = ["indirect_unused.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)
