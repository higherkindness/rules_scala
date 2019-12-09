load("@rules_scala_annex//rules:scala.bzl", "scala_library")
load("@rules_scala_annex//rules:providers.bzl", "reconfigure_deps_configuration")

reconfigure_deps_configuration(
    name = "scala",
    direct = select({
        ":deps_direct_off": "off",
        "//conditions:default": "error",
    }),
    provider = "//scala:2_12",
    used = select({
        ":deps_used_off": "off",
        "//conditions:default": "error",
    }),
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

scala_library(
    name = "a",
    srcs = ["A.scala"],
    scala = ":scala",
)

scala_library(
    name = "b",
    srcs = ["B.scala"],
    scala = ":scala",
    deps = [":a"],
)

scala_library(
    name = "c",
    srcs = ["C.scala"],
    scala = ":scala",
    deps = [":b"],
)
