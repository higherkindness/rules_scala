load("@rules_scala_annex//rules:build.bzl", "annex_scala_test")

annex_scala_test(
    name = "mixed",
    srcs = glob(["*.scala"]),
    scala = [
        "@scalas//:scala_2_12_4",
    ],
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
    ],
)
