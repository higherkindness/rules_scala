load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "monix_2_12",
    exports = [
        "//external:jar/io/monix/monix_2_12",
        ":monix_eval_2_12",
        ":monix_execution_2_12",
        ":monix_reactive_2_12",
        ":monix_types_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "monix_eval_2_12",
    exports = [
        "//external:jar/io/monix/monix_eval_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "monix_execution_2_12",
    exports = [
        "//3rdparty/jvm/org/reactivestreams:reactive_streams",
        "//external:jar/io/monix/monix_execution_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "monix_reactive_2_12",
    exports = [
        "//3rdparty/jvm/org/jctools:jctools_core",
        "//external:jar/io/monix/monix_reactive_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "monix_types_2_12",
    exports = [
        "//external:jar/io/monix/monix_types_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


