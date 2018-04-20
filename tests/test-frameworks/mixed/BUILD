load("@rules_scala_annex//rules:scala.bzl", "annex_scala_test")

annex_scala_test(
    name = "mixed",
    srcs = glob(["*.scala"]),
    scala = "@scala_2_12",
    shard_count = 2,
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
        "@org_scalactic_scalactic_2_12",
        "@org_scalatest_scalatest_2_12",
    ],
)
