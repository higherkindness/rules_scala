load("@rules_scala_annex//rules:scala.bzl", "annex_scala_binary")

annex_scala_binary(
    name = "bad",
    srcs = ["Main.scala"],
)

annex_scala_binary(
    name = "good",
    srcs = ["Main.scala"],
    deps = ["@org_scala_lang_modules_scala_xml_2_12//jar"],
)
