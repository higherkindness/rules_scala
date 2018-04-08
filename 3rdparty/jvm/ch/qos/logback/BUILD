load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "logback_classic",
    exports = [
        "//external:jar/ch/qos/logback/logback_classic"
    ],
    runtime_deps = [
        ":logback_core"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "logback_core",
    exports = [
        "//external:jar/ch/qos/logback/logback_core"
    ],
    visibility = [
        "//visibility:public"
    ]
)


