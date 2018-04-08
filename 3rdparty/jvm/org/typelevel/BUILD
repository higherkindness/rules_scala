load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "cats_core_2_12",
    exports = [
        "//external:jar/org/typelevel/cats_core_2_12"
    ],
    runtime_deps = [
        ":cats_kernel_2_12",
        ":cats_macros_2_12",
        ":machinist_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "cats_kernel_2_12",
    exports = [
        "//external:jar/org/typelevel/cats_kernel_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "cats_macros_2_12",
    exports = [
        "//external:jar/org/typelevel/cats_macros_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "machinist_2_12",
    exports = [
        "//external:jar/org/typelevel/machinist_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/org/scala_lang:scala_reflect"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "macro_compat_2_12",
    exports = [
        "//external:jar/org/typelevel/macro_compat_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "paiges_core_2_12",
    exports = [
        "//external:jar/org/typelevel/paiges_core_2_12"
    ],
    visibility = [
        "//visibility:public"
    ]
)


