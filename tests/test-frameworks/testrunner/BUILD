load("@rules_scala_annex//rules:scala.bzl", "scala_library", "scala_test")

scala_test(
    name = "testrunnertest",
    srcs = glob(["*.scala"]),
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_13",
        "@annex_test//:org_specs2_specs2_core_2_13",
        "@annex_test//:org_specs2_specs2_matcher_2_13",
    ],
)

scala_library(
    name = "aatestrunner",
    srcs = glob(["*.scala"]),
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_13",
        "@annex_test//:org_specs2_specs2_core_2_13",
        "@annex_test//:org_specs2_specs2_matcher_2_13",
    ],
)
