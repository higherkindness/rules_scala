load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "scalapb_circe_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":scalapb_json_common_2_12",
        "//3rdparty/jvm/io/circe:circe_parser_2_12",
        "//external:jar/io/github/scalapb_json/scalapb_circe_2_12",
    ],
)

java_library(
    name = "scalapb_json_common_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/io/github/scalapb_json/scalapb_json_common_2_12",
    ],
)
