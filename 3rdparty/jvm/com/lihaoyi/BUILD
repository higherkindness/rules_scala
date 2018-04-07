load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "fastparse_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/com/lihaoyi/fastparse_2_12",
    ],
    runtime_deps = [
        ":fastparse_utils_2_12",
        ":sourcecode_2_12",
    ],
)

java_library(
    name = "fastparse_utils_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/com/lihaoyi/fastparse_utils_2_12",
    ],
)

java_library(
    name = "sourcecode_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/com/lihaoyi/sourcecode_2_12",
    ],
)

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
