load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "okhttp",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/com/squareup/okhttp3/okhttp",
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/squareup/okio",
    ],
)

java_library(
    name = "okhttp_urlconnection",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//external:jar/com/squareup/okhttp3/okhttp_urlconnection",
    ],
)
