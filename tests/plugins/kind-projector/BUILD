load("@rules_scala_annex//rules:compat.bzl", "annex_scala_library")

scala = [
    "@scalas//:scala_2_12_4",
]

annex_scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "@kind_projector_2_12//jar",
    ],
    scala = scala,
    tags = ["manual"],
)
