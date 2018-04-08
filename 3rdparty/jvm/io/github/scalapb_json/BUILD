load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "scalapb_circe_2_12",
    exports = [
        "//external:jar/io/github/scalapb_json/scalapb_circe_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/io/circe:circe_parser_2_12",
        ":scalapb_json_common_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "scalapb_json_common_2_12",
    exports = [
        "//external:jar/io/github/scalapb_json/scalapb_json_common_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


