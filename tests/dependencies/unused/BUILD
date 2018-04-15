load("@rules_scala_annex//rules:compat.bzl", "annex_scala_library")

scala = [
    "@scalas//:scala_2_12_4",
]

annex_scala_library(
    name = "0_used",
    srcs = ["0_used.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
    ],
)

annex_scala_library(
    name = "0_unused",
    srcs = ["0_unused.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [
        "@org_scalacheck_scalacheck_2_12",
    ],
)
