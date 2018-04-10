load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "monix_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":monix_eval_2_12",
        ":monix_execution_2_12",
        ":monix_reactive_2_12",
        ":monix_types_2_12",
        "//external:jar/scala_annex_io/monix/monix_2_12",
    ],
)

java_library(
    name = "monix_eval_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_io/monix/monix_eval_2_12",
    ],
)

java_library(
    name = "monix_execution_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/org/reactivestreams:reactive_streams",
        "//external:jar/scala_annex_io/monix/monix_execution_2_12",
    ],
)

java_library(
    name = "monix_reactive_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/org/jctools:jctools_core",
        "//external:jar/scala_annex_io/monix/monix_reactive_2_12",
    ],
)

java_library(
    name = "monix_types_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/scala_annex_io/monix/monix_types_2_12",
    ],
)
