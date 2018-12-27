load(
    "@rules_scala_annex//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "bootstrap",
    actual = ":bootstrap_2_12_8",
    visibility = ["//visibility:public"],
)

alias(
    name = "zinc",
    actual = ":zinc_2_12_8",
    visibility = ["//visibility:public"],
)

compiler_classpath_2_12_8 = [
    "@scala_compiler_2_12_8//jar",
    "@scala_library_2_12_8//jar",
    "@scala_reflect_2_12_8//jar",
]

runtime_classpath_2_12_8 = [
    "@scala_library_2_12_8//jar",
]

configure_bootstrap_scala(
    name = "bootstrap_2_12_8",
    compiler_classpath = compiler_classpath_2_12_8,
    runtime_classpath = runtime_classpath_2_12_8,
    version = "2.12.8",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_12_8",
    srcs = [
        "@compiler_bridge_2_12//:src",
    ],
    scala = ":bootstrap_2_12_8",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_12_8 + [
        "@scala_annex_org_scala_sbt_compiler_interface//jar",
        "@scala_annex_org_scala_sbt_util_interface//jar",
    ],
)

configure_zinc_scala(
    name = "zinc_2_12_8",
    compiler_bridge = ":compiler_bridge_2_12_8",
    compiler_classpath = compiler_classpath_2_12_8,
    runtime_classpath = runtime_classpath_2_12_8,
    version = "2.12.8",
    visibility = ["//visibility:public"],
)
