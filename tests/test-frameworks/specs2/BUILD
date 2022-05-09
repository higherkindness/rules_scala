load("@rules_scala_annex//rules:scala.bzl", "scala_test")

scala_test(
    name = "specs2",
    srcs = glob(["*.scala"]),
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_13",
        "@annex_test//:org_specs2_specs2_core_2_13",
        "@annex_test//:org_specs2_specs2_matcher_2_13",
    ],
)
