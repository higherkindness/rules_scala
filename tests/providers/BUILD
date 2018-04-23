load(
    "@rules_scala_annex//rules:providers.bzl",
    "declare_scala_configuration",
    "declare_zinc_configuration",
    "join_configurations",
)
load(
    "@rules_scala_annex//rules:scalac.bzl",
    "scalac_library",
)
load(
    ":build.bzl",
    "consume_scala_configuration",
    "consume_zinc_configuration",
    "consume_scala_and_zinc_configuration",
)

declare_scala_configuration(
    name = "provided_scala_configuration",
    compiler_classpath = [
        "@scala_2_12_scala_compiler//jar",
        "@scala_2_12_scala_reflect//jar",
        "@scala_2_12_scala_library//jar",
    ],
    runtime_classpath = [
        "@scala_2_12_scala_library//jar",
    ],
    version = "2.12.4",
)

scalac_library(
    name = "compiler_bridge",
    srcs = ["@compiler_bridge_2_12//:src"],
    scala = ":provided_scala_configuration",
    deps = [
        "@scala_2_12_scala_compiler//jar",
        "@scala_2_12_scala_library//jar",
        "@scala_2_12_scala_reflect//jar",
        "@scala_annex_org_scala_sbt_compiler_interface",
        "@scala_annex_org_scala_sbt_util_interface",
    ],
)

declare_zinc_configuration(
    name = "provided_zinc_configuration",
    compiler_bridge = ":compiler_bridge",
)

join_configurations(
    name = "provided_scala_and_zinc_configuration",
    configurations = [
        ":provided_scala_configuration",
        ":provided_zinc_configuration",
    ],
)

consume_scala_configuration(
    name = "consume_scala_configuration",
    configuration = ":provided_scala_configuration",
)

consume_scala_configuration(
    name = "consume_scala_as_zinc_configuration",
    configuration = ":provided_zinc_configuration",
)

consume_zinc_configuration(
    name = "consume_zinc_configuration",
    configuration = ":provided_zinc_configuration",
)

consume_zinc_configuration(
    name = "consume_zinc_as_scala_configuration",
    configuration = ":provided_scala_configuration",
)

consume_scala_and_zinc_configuration(
    name = "consume_scala_and_zinc_configuration",
    configuration = ":provided_scala_and_zinc_configuration",
)

consume_scala_configuration(
    name = "consume_scala_and_zinc_as_scala_configuration",
    configuration = ":provided_scala_and_zinc_configuration",
)

consume_zinc_configuration(
    name = "consume_scala_and_zinc_as_zinc_configuration",
    configuration = ":provided_scala_and_zinc_configuration",
)
