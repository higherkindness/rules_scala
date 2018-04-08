load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "fansi_2_12",
    exports = [
        "//external:jar/com/lihaoyi/fansi_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "fastparse_2_12",
    exports = [
        "//external:jar/com/lihaoyi/fastparse_2_12"
    ],
    runtime_deps = [
        ":fastparse_utils_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "fastparse_utils_2_12",
    exports = [
        "//external:jar/com/lihaoyi/fastparse_utils_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "pprint_2_12",
    exports = [
        "//external:jar/com/lihaoyi/pprint_2_12"
    ],
    runtime_deps = [
        ":fansi_2_12",
        ":sourcecode_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "scalatags_2_12",
    exports = [
        "//external:jar/com/lihaoyi/scalatags_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "sourcecode_2_12",
    exports = [
        "//external:jar/com/lihaoyi/sourcecode_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



scala_import(
    name = "utest",
    jars = [
        "//external:jar/com/lihaoyi/utest_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_library",
        "//3rdparty/jvm/org/scala_lang:scala_reflect",
        "//3rdparty/jvm/org/scala_sbt:test_interface"
    ],
    visibility = [
        "//visibility:public"
    ]
)


