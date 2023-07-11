load("@rules_scala_annex//rules:scala.bzl", "configure_zinc_scala", "scala_library")

scala_library(
    name = "kind-projector",
    srcs = ["KindProjector.scala"],
    plugins = [
        "@annex_test//:org_typelevel_kind_projector_2_13_11",
    ],
    tags = ["manual"],
)

configure_zinc_scala(
    name = "scala_2_13_11_with_kind_projector",
    compiler_bridge = "@annex//:org_scala_sbt_compiler_bridge_2_13",
    compiler_classpath = [
        "@annex//:org_scala_lang_scala_compiler_2_13_11",
        "@annex//:org_scala_lang_scala_reflect_2_13_11",
        "@annex//:org_scala_lang_scala_library_2_13_11",
    ],
    global_plugins = [
        "@annex_test//:org_typelevel_kind_projector_2_13_11",
    ],
    runtime_classpath = [
        "@annex//:org_scala_lang_scala_library_2_13_11",
    ],
    version = "2.13.11",
)

scala_library(
    name = "kind-projector-via-global-plugins",
    srcs = ["KindProjector.scala"],
    scala = ":scala_2_13_11_with_kind_projector",
    tags = ["manual"],
)
