load("@rules_scala_annex//rules:compat.bzl", "annex_scala_library")

scala = [
    "@scalas//:scala_2_11_11",
]

annex_scala_library(
    name = "library",
    srcs = ["code.scala"],
    scala = scala,
    tags = ["manual"],
)
