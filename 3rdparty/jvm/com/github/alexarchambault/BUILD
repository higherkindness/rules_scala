load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "case_app_2_12",
    exports = [
        "//external:jar/com/github/alexarchambault/case_app_2_12"
    ],
    runtime_deps = [
        ":case_app_annotations_2_12",
        ":case_app_util_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "case_app_annotations_2_12",
    exports = [
        "//external:jar/com/github/alexarchambault/case_app_annotations_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "case_app_util_2_12",
    exports = [
        "//external:jar/com/github/alexarchambault/case_app_util_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/chuusai:shapeless_2_12",
        "//3rdparty/jvm/org/typelevel:macro_compat_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


