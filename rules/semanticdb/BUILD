load("@rules_scala_annex//rules:scala.bzl", "scala_library")
load(
    ":private.bzl",
    _make_semanticdb_plugin = "make_semanticdb_plugin",
)

scala_library(
    name = "lib",
    scala = "//external:scala_annex_scala",
)

_make_semanticdb_plugin(
    name = "2_12_7",
    dep = "@scala_annex_org_scalameta_semanticdb_scalac_2_12_7",
    visibility = ["//visibility:public"],
)
