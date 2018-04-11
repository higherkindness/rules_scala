load("@rules_scala_annex//rules:bazel_deps.bzl", "scala_import")

scala_import(
    name = "utest",
    jars = [
        "//external:jar/com/lihaoyi/utest_2_12",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scala_sbt:test_interface",
    ],
)
