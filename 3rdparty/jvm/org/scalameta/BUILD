load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "common_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_org/scalameta/common_2_12",
    ],
)

java_library(
    name = "inputs_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":common_2_12",
        ":io_2_12",
        ":langmeta_2_12",
        "//external:jar/scala_annex_org/scalameta/inputs_2_12",
    ],
)

java_library(
    name = "io_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_org/scalameta/io_2_12",
    ],
)

java_library(
    name = "jsonrpc_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/ch/qos/logback:logback_classic",
        "//3rdparty/jvm/com/beachape:enumeratum_2_12",
        "//3rdparty/jvm/com/beachape:enumeratum_circe_2_12",
        "//3rdparty/jvm/com/typesafe/scala_logging:scala_logging_2_12",
        "//3rdparty/jvm/io/circe:circe_generic_2_12",
        "//3rdparty/jvm/io/circe:circe_generic_extras_2_12",
        "//3rdparty/jvm/org/codehaus/groovy",
        "//external:jar/scala_annex_org/scalameta/jsonrpc_2_12",
    ],
)

java_library(
    name = "langmeta_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/com/trueaccord/scalapb:scalapb_runtime_2_12",
        "//external:jar/scala_annex_org/scalameta/langmeta_2_12",
    ],
)

java_library(
    name = "lsp4s_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":jsonrpc_2_12",
        "//external:jar/scala_annex_org/scalameta/lsp4s_2_12",
    ],
)
