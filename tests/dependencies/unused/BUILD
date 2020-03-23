load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala_library(
    name = "0_used",
    srcs = ["0_used.scala"],
    scala = "//scala:2_12",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_12",
    ],
)

scala_library(
    name = "0_unused",
    srcs = ["0_unused.scala"],
    scala = "//scala:2_12",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_12",
    ],
)

scala_library(
    name = "0_unused_whitelist",
    srcs = ["0_unused.scala"],
    deps_used_whitelist = [
        "@annex_test//:org_scalacheck_scalacheck_2_12",
    ],
    scala = "//scala:2_12",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_12",
    ],
)

scala_library(
    name = "indirect_unused",
    srcs = ["indirect_unused.scala"],
    scala = "//scala:2_12",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
        "@annex_test//:org_specs2_specs2_matcher_2_12",
    ],
)

scala_library(
    name = "indirect_unused_missing",
    srcs = ["indirect_unused.scala"],
    scala = "//scala:2_12",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
    ],
)

scala_library(
    name = "indirect_unused_whitelist",
    srcs = ["indirect_unused.scala"],
    deps_unused_whitelist = [
        "@annex_test//:org_specs2_specs2_matcher_2_12",
    ],
    scala = "//scala:2_12",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
    ],
)
