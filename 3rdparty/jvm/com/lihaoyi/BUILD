load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "fansi_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_com/lihaoyi/fansi_2_12",
    ],
)

java_library(
    name = "fastparse_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":fastparse_utils_2_12",
        "//external:jar/scala_annex_com/lihaoyi/fastparse_2_12",
    ],
)

java_library(
    name = "fastparse_utils_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_com/lihaoyi/fastparse_utils_2_12",
    ],
)

java_library(
    name = "pprint_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":fansi_2_12",
        ":sourcecode_2_12",
        "//external:jar/scala_annex_com/lihaoyi/pprint_2_12",
    ],
)

java_library(
    name = "scalatags_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_com/lihaoyi/scalatags_2_12",
    ],
)

java_library(
    name = "sourcecode_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_com/lihaoyi/sourcecode_2_12",
    ],
)

scala_import(
    name = "utest",
    jars = [
        "//external:jar/scala_annex_com/lihaoyi/utest_2_12",
    ],
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scala_sbt:test_interface",
    ],
)
