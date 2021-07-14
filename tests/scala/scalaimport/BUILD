load("@rules_scala_annex//rules:scala.bzl", "scala_import", "scala_library")

scala_import(
    name = "shapeless",
    jars = [
        "@shapeless_jar//file",
        "@shapeless_srcjar//file",
    ],
    visibility = [
        "//visibility:public",
    ],
)

scala_library(
    name = "scalaimport",
    srcs = ["scalaimport.scala"],
    deps = [
        ":shapeless",
        "@annex_test//:org_scala_lang_modules_scala_xml_2_13",
    ],
)
