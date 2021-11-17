load("@rules_scala_annex//rules:scala.bzl", "scala_binary")

scala_binary(
    name = "bad",
    srcs = ["Main.scala"],
)

scala_binary(
    name = "good",
    srcs = ["Main.scala"],
    deps = ["@annex_test//:org_scala_lang_modules_scala_xml_2_13"],
)
