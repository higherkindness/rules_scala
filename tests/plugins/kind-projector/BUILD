load("@rules_scala_annex//rules:scala.bzl", "configure_scala", "scala_library")

scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "@kind_projector_2_12//jar",
    ],
    scala = "@scala_2_12",
    tags = ["manual"],
)

configure_scala(
    name = "scala_2_12_with_kind_projector",
    compiler_bridge = "@scala_2_12//:compiler_bridge",
    compiler_classpath = [
        "@scala_2_12_scala_compiler//jar",
        "@scala_2_12_scala_reflect//jar",
        "@scala_2_12_scala_library//jar",
    ],
    global_plugins = [
        "@kind_projector_2_12//jar",
    ],
    runtime_classpath = [
        "@scala_2_12_scala_library//jar",
    ],
    version = "2.12.x",
)

scala_library(
    name = "kind-projector-via-global-plugins",
    srcs = ["KindProjector.scala"],
    scala = ":scala_2_12_with_kind_projector",
    tags = ["manual"],
)
