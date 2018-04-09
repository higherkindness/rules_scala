load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "config",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_com/typesafe/config",
    ],
)

java_library(
    name = "ssl_config_core_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":config",
        "//external:jar/scala_annex_com/typesafe/ssl_config_core_2_12",
    ],
)
