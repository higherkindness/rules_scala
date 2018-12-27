load("@rules_scala_annex//rules:scala.bzl", "scala_library")
load("@rules_scala_annex//rules:providers.bzl", "reconfigure_deps_configuration")

reconfigure_deps_configuration(
    name = "scala",
    provider = "//scala:2_12",
    used = "off",
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
