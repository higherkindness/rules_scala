load("@rules_scala_annex//rules:scala.bzl", "scala_test")

scala_test(
    name = "mixed_2_12",
    srcs = glob(["*.scala"]),
    scala = "//scala:2_12",
    shard_count = 2,
    tags = ["manual"],
    runtime_deps = [
        "@hamcrest_core//jar",
        "@junit_interface//jar",
    ],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_12",
        "@annex_test//:org_scalactic_scalactic_2_12",
        "@annex_test//:org_scalatest_scalatest_2_12",
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
        "@annex_test//:org_specs2_specs2_matcher_2_12",
        "@junit//jar",
    ],
)

scala_test(
    name = "mixed_2_11",
    srcs = [
        "scalacheck.scala",
        "specs2.scala",
    ],
    scala = "//scala:2_11",
    tags = ["manual"],
    deps = [
        "@annex_test//:org_scalacheck_scalacheck_2_11",
        "@annex_test//:org_specs2_specs2_common_2_11",
        "@annex_test//:org_specs2_specs2_core_2_11",
        "@annex_test//:org_specs2_specs2_matcher_2_11",
    ],
)
