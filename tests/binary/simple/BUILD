load("//rules:build.bzl", "annex_scala_binary")

scala = [
    "@scalas//:scala_2_11_12",
    "@scalas//:scala_2_12_4",
]

annex_scala_binary(
    name = "one_discovered",
    srcs = ["one_discovered.scala"],
    scala = scala,
    tags = ["manual"],
)
