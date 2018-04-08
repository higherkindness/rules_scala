load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "gigahorse_core_2_12",
    exports = [
        "//external:jar/com/eed3si9n/gigahorse_core_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/typesafe:ssl_config_core_2_12",
        "//3rdparty/jvm/org/reactivestreams:reactive_streams",
        "//3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "gigahorse_okhttp_2_12",
    exports = [
        "//external:jar/com/eed3si9n/gigahorse_okhttp_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/squareup/okhttp3:okhttp",
        ":gigahorse_core_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "shaded_scalajson_2_12",
    exports = [
        "//external:jar/com/eed3si9n/shaded_scalajson_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "sjson_new_core_2_12",
    exports = [
        "//external:jar/com/eed3si9n/sjson_new_core_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "sjson_new_murmurhash_2_12",
    exports = [
        "//external:jar/com/eed3si9n/sjson_new_murmurhash_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "sjson_new_scalajson_2_12",
    exports = [
        "//external:jar/com/eed3si9n/sjson_new_scalajson_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/spire_math:jawn_parser_2_12",
        ":shaded_scalajson_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


