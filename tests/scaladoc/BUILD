load("@rules_scala_annex//rules:scala.bzl", "scaladoc")

scaladoc(
    name = "a_doc",
    srcs = [
        "A.scala",
        "B.scala",
    ],
    compiler_deps = [
        "@org_scala_lang_modules_scala_xml_2_12",
    ],
    scala = "@scala_2_12",
)
