load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "config",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/com/typesafe/config",
    ],
)

java_library(
    name = "ssl_config_core_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":config",
        "//external:jar/com/typesafe/ssl_config_core_2_12",
    ],
)
