load("//rules:bazel_deps.bzl", "scala_import")
scala_import(
    name = "scalatest",
    jars = [
        "//external:jar/org/scalatest/scalatest_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_parser_combinators_2_12",
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml_2_12",
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scalactic:scalactic_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


