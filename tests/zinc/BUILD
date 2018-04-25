load(
    "@rules_scala_annex//rules:scala.bzl",
    "annex_scala_library",
    "annex_scala_binary",
)
load(
    "@rules_scala_annex//rules:providers.bzl",
    "zinc_info",
)

annex_scala_library(
    name = "source",
    srcs = ["source.scala"],
    scala = "@scala_2_12",
)

zinc_info(
    name = "source-analysis",
    dep = ":source",
)

annex_scala_binary(
    name = "tool",
    srcs = ["tool.scala"],
    args = ["$(location :source-analysis)"],
    data = [":source-analysis"],
    scala = "@scala_2_12",
    runtime_deps = [
        "@scala_annex_org_scala_sbt_zinc_core_2_12",
    ],
    deps = [
        "@scala_annex_com_trueaccord_scalapb_scalapb_runtime_2_12",
        #"@scala_annex_org_scala_sbt_compiler_interface",
        #"@scala_annex_org_scala_sbt_zinc_core_2_12",
        "@scala_annex_org_scala_sbt_zinc_persist_2_12",
    ],
)
