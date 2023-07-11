load(
    "@rules_scala_annex//rules:scala.bzl",
    "configure_bootstrap_scala",
    "configure_zinc_scala",
    "scala_library",
)

alias(
    name = "bootstrap",
    actual = ":bootstrap_2_13_11",
    visibility = ["//visibility:public"],
)

alias(
    name = "bootstrap_3",
    actual = ":bootstrap_3_3_0",
    visibility = ["//visibility:public"],
)

alias(
    name = "zinc",
    actual = ":zinc_2_13_11",
    visibility = ["//visibility:public"],
)

alias(
    name = "zinc_3",
    actual = ":zinc_3_3_0",
    visibility = ["//visibility:public"],
)

# Scala 2.13
compiler_classpath_2_13_11 = [
    "@annex//:org_scala_lang_scala_compiler",
    "@annex//:org_scala_lang_scala_library",
    "@annex//:org_scala_lang_scala_reflect",
]

runtime_classpath_2_13_11 = [
    "@annex//:org_scala_lang_scala_library",
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

# Scala 3

# Adding this, so we make sure to have a Scala library in the
# IntelliJ libraries, so we can get a Scala SDK on sync.
scala_library(
    name = "scala-sdk",
    deps_used_whitelist = [
        "@annex_3//:org_scala_lang_scala3_library_3_3_3_0",
    ],
    scala = ":zinc_3",
    deps = [
        "@annex_3//:org_scala_lang_scala3_library_3_3_3_0",
    ],
)

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

config_setting(
    name = "deps_used_off",
    define_values = {
        "scala_deps_used": "off",
    },
)

config_setting(
    name = "deps_direct_off",
    define_values = {
        "scala_deps_direct": "off",
    },
)
