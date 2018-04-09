load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "logback_classic",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":logback_core",
        "//external:jar/ch/qos/logback/logback_classic",
    ],
)

java_library(
    name = "logback_core",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/ch/qos/logback/logback_core",
    ],
)
