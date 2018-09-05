load("@rules_scala_annex//rules:scala.bzl", "scala_library")

scala = "@scala_2_12"

scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "@kind_projector_2_12//jar",
    ],
    scala = scala,
    tags = ["manual"],
)
