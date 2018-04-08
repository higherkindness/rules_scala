load("//rules:bazel_deps.bzl", "scala_import")
java_library(
    name = "directory_watcher",
    exports = [
        "//external:jar/io/methvin/directory_watcher"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/google/guava:guava",
        "//3rdparty/jvm/org/slf4j:slf4j_api"
    ],
    visibility = [
        "//visibility:public"
    ]
)



java_library(
    name = "directory_watcher_better_files_2_12",
    exports = [
        "//external:jar/io/methvin/directory_watcher_better_files_2_12"
    ],
    runtime_deps = [
        "//3rdparty/jvm/com/github/pathikrit:better_files_2_12",
        ":directory_watcher"
    ],
    visibility = [
        "//visibility:public"
    ]
)


