load("@rules_scala_annex//rules:scala.bzl", "scaladoc")

scaladoc(
    name = "a_doc",
    srcs = [
        "A.scala",
        "B.scala",
    ],
    compiler_deps = [
        "@annex_test//:org_scala_lang_modules_scala_xml_2_13",
    ],
    scala = "//scala:2_13",
    deps = [
        "//mockutil:mocklib",
    ],
)
