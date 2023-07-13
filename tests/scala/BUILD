load(
    "@rules_scala_annex//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "2_12",
    actual = ":zinc_2_12_14",
    visibility = ["//visibility:public"],
)

alias(
    name = "2_13",
    actual = ":zinc_2_13_11",
    visibility = ["//visibility:public"],
)

alias(
    name = "3",
    actual = ":zinc_3_3_0",
    visibility = ["//visibility:public"],
)

# zinc 2.12.14

compiler_classpath_2_12_14 = [
    "@annex_2_12//:org_scala_lang_scala_compiler_2_12_14",
    "@annex_2_12//:org_scala_lang_scala_reflect_2_12_14",
    "@annex_2_12//:org_scala_lang_scala_library_2_12_14",
]

runtime_classpath_2_12_14 = [
    "@annex_2_12//:org_scala_lang_scala_library_2_12_14",
]

configure_bootstrap_scala(
    name = "bootstrap_2_12_14",
    compiler_classpath = compiler_classpath_2_12_14,
    runtime_classpath = runtime_classpath_2_12_14,
    version = "2.12.14",
    visibility = ["//visibility:public"],
)

configure_zinc_scala(
    name = "zinc_2_12_14",
    compiler_bridge = "@annex_2_12//:org_scala_sbt_compiler_bridge_2_12",
    compiler_classpath = compiler_classpath_2_12_14,
    runtime_classpath = runtime_classpath_2_12_14,
    version = "2.12.14",
    visibility = ["//visibility:public"],
)

# zinc 2.13.11

compiler_classpath_2_13_11 = [
    "@annex//:org_scala_lang_scala_compiler_2_13_11",
    "@annex//:org_scala_lang_scala_reflect_2_13_11",
    "@annex//:org_scala_lang_scala_library_2_13_11",
]

runtime_classpath_2_13_11 = [
    "@annex//:org_scala_lang_scala_library_2_13_11",
]

configure_bootstrap_scala(
    name = "bootstrap_2_13_11",
    compiler_classpath = compiler_classpath_2_13_11,
    runtime_classpath = runtime_classpath_2_13_11,
    version = "2.13.11",
    visibility = ["//visibility:public"],
)

configure_zinc_scala(
    name = "zinc_2_13_11",
    compiler_bridge = "@annex//:org_scala_sbt_compiler_bridge_2_13",
    compiler_classpath = compiler_classpath_2_13_11,
    global_scalacopts = [
        "-Ytasty-reader",
    ],
    runtime_classpath = runtime_classpath_2_13_11,
    version = "2.13.11",
    visibility = ["//visibility:public"],
)

# zinc 3.3.0

compiler_classpath_3_3_0 = [
    "@annex_3//:org_scala_lang_scala3_compiler_3_3_3_0",
    "@annex_3//:org_scala_lang_scala3_library_3_3_3_0",
]

runtime_classpath_3_3_0 = [
    "@annex_3//:org_scala_lang_scala3_library_3_3_3_0",
    "@annex_3//:org_scala_lang_scala3_interfaces",
    "@annex_3//:org_scala_lang_tasty_core_3",
]

configure_bootstrap_scala(
    name = "bootstrap_3_3_0",
    compiler_classpath = compiler_classpath_3_3_0,
    runtime_classpath = runtime_classpath_3_3_0,
    use_ijar = False,
    version = "3.3.0",
    visibility = ["//visibility:public"],
)

configure_zinc_scala(
    name = "zinc_3_3_0",
    compiler_bridge = "@annex_3//:org_scala_lang_scala3_sbt_bridge_3_3_0",
    compiler_classpath = compiler_classpath_3_3_0,
    runtime_classpath = runtime_classpath_3_3_0,
    use_ijar = False,
    version = "3.3.0",
    visibility = ["//visibility:public"],
)

# For global scalacoptions test
configure_zinc_scala(
    name = "zinc_2_13_11_fatal_deprecation_opt",
    compiler_bridge = "@annex//:org_scala_sbt_compiler_bridge_2_13",
    compiler_classpath = compiler_classpath_2_13_11,
    global_scalacopts = [
        "-deprecation",
        "-Xfatal-warnings",
    ],
    runtime_classpath = runtime_classpath_2_13_11,
    version = "2.13.11",
    visibility = ["//scalacopts/rule:__subpackages__"],
)

# for log_level test
configure_zinc_scala(
    name = "zinc_2_13_11_log_level_debug",
    compiler_bridge = "@annex//:org_scala_sbt_compiler_bridge_2_13",
    compiler_classpath = compiler_classpath_2_13_11,
    log_level = "debug",
    runtime_classpath = runtime_classpath_2_13_11,
    version = "2.13.11",
    visibility = ["//visibility:public"],
)
