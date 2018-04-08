load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "scalapb_runtime_2_12",
    exports = [
        "//external:jar/com/trueaccord/scalapb/scalapb_runtime_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/protobuf:protobuf_java",
        "//3rdparty/jvm/com/lihaoyi:fastparse_2_12",
        "//3rdparty/jvm/com/trueaccord/lenses:lenses_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


