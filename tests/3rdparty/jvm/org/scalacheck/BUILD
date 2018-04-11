load("@rules_scala_annex//rules:bazel_deps.bzl", "scala_import")

scala_import(
    name = "scalacheck",
    jars = [
        "//external:jar/org/scalacheck/scalacheck_2_12",
    ],
    visibility = [
        "//visibility:public",
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_sbt:test_interface",
    ],
)
