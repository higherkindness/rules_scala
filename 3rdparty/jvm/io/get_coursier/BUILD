load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "coursier_2_12",
    exports = [
        "//external:jar/io/get_coursier/coursier_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang/modules:scala_xml_2_12",
        "//3rdparty/jvm/org/scalaz:scalaz_core_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "coursier_cache_2_12",
    exports = [
        "//external:jar/io/get_coursier/coursier_cache_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scalaz:scalaz_concurrent_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


