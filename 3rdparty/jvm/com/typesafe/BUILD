load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "config",
    exports = [
        "//external:jar/com/typesafe/config"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "ssl_config_core_2_12",
    exports = [
        "//external:jar/com/typesafe/ssl_config_core_2_12"
    ],
    runtime_deps = [
        ":config"
    ],
    visibility = [
        "//visibility:public"
    ]
)


