load("@rules_scala_annex//rules:scala.bzl", "annex_scala_binary", "annex_scala_library")

annex_scala_library(
    name = "bad",
    srcs = ["Reflect.scala"],
    scala = "@scala_2_12",
)

annex_scala_binary(
    name = "good",
    srcs = ["Reflect.scala"],
    deps_used_whitelist = ["@org_scala_lang_scala_reflect"],
    scala = "@scala_2_12",
    deps = ["@org_scala_lang_scala_reflect"],
)
