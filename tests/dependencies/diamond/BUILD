load("//rules:build.bzl", "annex_scala_library")

scala = [
    # "@scalas//:scala_2_10_7",
    "@scalas//:scala_2_11_0",
    "@scalas//:scala_2_12_0",
]

#
# diamond dep DAG:
#
#   /--> B1 --\
# C            > A
#   \--> B2 --/
#

annex_scala_library(
    name = "A",
    srcs = ["A.scala"],
    scala = scala,
    tags = ["manual"],
)

annex_scala_library(
    name = "B1",
    srcs = ["B1.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [":A"],
)

annex_scala_library(
    name = "B2",
    srcs = ["B2.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [":A"],
)

annex_scala_library(
    name = "C",
    srcs = ["C.scala"],
    scala = scala,
    tags = ["manual"],
    deps = [
        ":B1",
        ":B2",
    ],
)
