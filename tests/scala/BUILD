load(
    "@rules_scala_annex//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "2_11",
    actual = ":zinc_2_11_12",
    visibility = ["//visibility:public"],
)

alias(
    name = "2_12",
    actual = ":zinc_2_12_6",
    visibility = ["//visibility:public"],
)

# zinc 2.11.12

compiler_classpath_2_11_12 = [
    "@scala_compiler_2_11_12//jar",
    "@scala_library_2_11_12//jar",
    "@scala_reflect_2_11_12//jar",
]

runtime_classpath_2_11_12 = [
    "@scala_library_2_11_12//jar",
]

configure_bootstrap_scala(
    name = "bootstrap_2_11_12",
    compiler_classpath = compiler_classpath_2_11_12,
    runtime_classpath = runtime_classpath_2_11_12,
    version = "2.11.12",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_11_12",
    srcs = [
        "@compiler_bridge_2_11//:src",
    ],
    scala = ":bootstrap_2_11_12",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_11_12 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_11_12",
    compiler_bridge = ":compiler_bridge_2_11_12",
    compiler_classpath = compiler_classpath_2_11_12,
    runtime_classpath = runtime_classpath_2_11_12,
    version = "2.11.12",
    visibility = ["//visibility:public"],
)

# zinc 2.12.6

compiler_classpath_2_12_6 = [
    "@scala_compiler_2_12_6//jar",
    "@scala_library_2_12_6//jar",
    "@scala_reflect_2_12_6//jar",
]

runtime_classpath_2_12_6 = [
    "@scala_library_2_12_6//jar",
]

configure_bootstrap_scala(
    name = "bootstrap_2_12_6",
    compiler_classpath = compiler_classpath_2_12_6,
    runtime_classpath = runtime_classpath_2_12_6,
    version = "2.12.6",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_2_12_6",
    srcs = [
        "@compiler_bridge_2_12//:src",
    ],
    scala = ":bootstrap_2_12_6",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_2_12_6 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_2_12_6",
    compiler_bridge = ":compiler_bridge_2_12_6",
    compiler_classpath = compiler_classpath_2_12_6,
    runtime_classpath = runtime_classpath_2_12_6,
    version = "2.12.6",
    visibility = ["//visibility:public"],
)

# zinc + typelevel 2.12.1

compiler_classpath_typelevel_2_12_1 = [
    "@scala_compiler_typelevel_2_12_1//jar",
    "@scala_library_typelevel_2_12_1//jar",
    "@scala_reflect_typelevel_2_12_1//jar",
]

runtime_classpath_typelevel_2_12_1 = [
    "@scala_library_typelevel_2_12_1//jar",
]

configure_bootstrap_scala(
    name = "bootstrap_typelevel_2_12_1",
    compiler_classpath = compiler_classpath_typelevel_2_12_1,
    runtime_classpath = runtime_classpath_typelevel_2_12_1,
    version = "2.12.1",
    visibility = ["//visibility:public"],
)

scala_library(
    name = "compiler_bridge_typelevel_2_12_1",
    srcs = [
        "@compiler_bridge_2_12//:src",
    ],
    scala = ":bootstrap_typelevel_2_12_1",
    visibility = ["//visibility:public"],
    deps = compiler_classpath_typelevel_2_12_1 + [
        "@annex//:org_scala_sbt_compiler_interface",
        "@annex//:org_scala_sbt_util_interface",
    ],
)

configure_zinc_scala(
    name = "zinc_typelevel_2_12_1",
    compiler_bridge = ":compiler_bridge_typelevel_2_12_1",
    compiler_classpath = compiler_classpath_typelevel_2_12_1,
    runtime_classpath = runtime_classpath_typelevel_2_12_1,
    version = "2.12.1",
    visibility = ["//visibility:public"],
)

# For global scalacoptions test
configure_zinc_scala(
    name = "zinc_2_12_6_fatal_deprecation_opt",
    compiler_bridge = ":compiler_bridge_2_12_6",
    compiler_classpath = compiler_classpath_2_12_6,
    global_scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
    runtime_classpath = runtime_classpath_2_12_6,
    version = "2.12.6",
    visibility = ["//scalacopts/rule:__subpackages__"],
)

# for log_level test
configure_zinc_scala(
    name = "zinc_2_12_6_log_level_debug",
    compiler_bridge = ":compiler_bridge_2_12_6",
    compiler_classpath = compiler_classpath_2_12_6,
    log_level = "debug",
    runtime_classpath = runtime_classpath_2_12_6,
    version = "2.12.6",
    visibility = ["//visibility:public"],
)
