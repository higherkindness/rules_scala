load("@rules_scala_annex//rules:scala.bzl", "scala_binary", "scala_library")

scala_library(
    name = "bad",
    srcs = ["Reflect.scala"],
    scala = "//scala:2_13",
)

scala_binary(
    name = "good",
    srcs = ["Reflect.scala"],
    deps_used_whitelist = ["@annex//:org_scala_lang_scala_reflect"],
    scala = "//scala:2_13",
    deps = ["@annex//:org_scala_lang_scala_reflect"],
)
