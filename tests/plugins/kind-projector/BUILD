load("@rules_scala_annex//rules:scala.bzl", "configure_scala", "scala_library")

scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "@kind_projector_2_12//jar",
    ],
    tags = ["manual"],
)

configure_scala(
    name = "scala_2_12_6_with_kind_projector",
    compiler_bridge = "//scala:compiler_bridge_2_12_6",
    compiler_classpath = [
        "@scala_compiler_2_12_6//jar",
        "@scala_reflect_2_12_6//jar",
        "@scala_library_2_12_6//jar",
    ],
    global_plugins = [
        "@kind_projector_2_12//jar",
    ],
    runtime_classpath = [
        "@scala_library_2_12_6//jar",
    ],
    version = "2.12.6",
)

scala_library(
    name = "kind-projector-via-global-plugins",
    srcs = ["KindProjector.scala"],
    scala = ":scala_2_12_6_with_kind_projector",
    tags = ["manual"],
)
