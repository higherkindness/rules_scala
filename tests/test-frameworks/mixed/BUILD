load("@rules_scala_annex//rules:scala.bzl", "annex_scala_test")

annex_scala_test(
    name = "mixed_2_12",
    srcs = glob(["*.scala"]),
    scala = "@scala_2_12",
    shard_count = 2,
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
        "@org_scalactic_scalactic_2_12",
        "@org_scalatest_scalatest_2_12",
        "@org_specs2_specs2_common_2_12",
        "@org_specs2_specs2_core_2_12",
        "@org_specs2_specs2_matcher_2_12",
    ],
)

annex_scala_test(
    name = "mixed_2_11",
    srcs = [
        "DummyProperties.scala",
        "DummySpec2.scala",
    ],
    scala = "@scala_2_11",
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_11//jar",
        "@org_specs2_specs2_common_2_11",
        "@org_specs2_specs2_core_2_11",
        "@org_specs2_specs2_matcher_2_11",
    ],
)
