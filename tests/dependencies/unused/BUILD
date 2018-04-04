load("//rules:build.bzl", "annex_scala_library")

scala = [
      "@scalas//:scala_2_12_4",
]

annex_scala_library(
    name = "0_used",
    srcs = ["0_used.scala"],
    deps = [
         "//3rdparty/jvm/org/scalacheck",
    ],
    scala = scala,
    tags = ["manual"],
)

annex_scala_library(
    name = "0_unused",
    srcs = ["0_unused.scala"],
    deps = [
         "//3rdparty/jvm/org/scalacheck",
    ],
    scala = scala,
    tags = ["manual"],
)
