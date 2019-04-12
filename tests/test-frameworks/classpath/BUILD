load("@rules_scala_annex//rules:scala.bzl", "scala_test")

scala_test(
    name = "bad",
    srcs = ["Test.scala"],
    scala = "//scala:2_12",
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
        "@annex_test//:org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "context",
    srcs = ["ContextTest.scala"],
    scala = "//scala:2_12",
    deps = [
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
        "@annex_test//:org_specs2_specs2_matcher_2_12",
    ],
)

scala_test(
    name = "good",
    srcs = ["Test.scala"],
    deps_used_whitelist = [
        "@annex//:org_scala_sbt_zinc_persist_2_12",
    ],
    scala = "//scala:2_12",
    deps = [
        "@annex//:org_scala_sbt_zinc_persist_2_12",
        "@annex_test//:org_specs2_specs2_common_2_12",
        "@annex_test//:org_specs2_specs2_core_2_12",
        "@annex_test//:org_specs2_specs2_matcher_2_12",
    ],
)
