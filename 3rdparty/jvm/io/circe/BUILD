load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "circe_core_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":circe_numbers_2_12",
        "//3rdparty/jvm/org/typelevel:cats_core_2_12",
        "//external:jar/io/circe/circe_core_2_12",
    ],
)

java_library(
    name = "circe_derivation_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":circe_core_2_12",
        "//external:jar/io/circe/circe_derivation_2_12",
    ],
)

java_library(
    name = "circe_generic_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/io/circe/circe_generic_2_12",
    ],
)

java_library(
    name = "circe_generic_extras_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/io/circe/circe_generic_extras_2_12",
    ],
)

java_library(
    name = "circe_jawn_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/org/spire_math:jawn_parser_2_12",
        "//external:jar/io/circe/circe_jawn_2_12",
    ],
)

java_library(
    name = "circe_numbers_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/io/circe/circe_numbers_2_12",
    ],
)

java_library(
    name = "circe_parser_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":circe_jawn_2_12",
        "//external:jar/io/circe/circe_parser_2_12",
    ],
)
