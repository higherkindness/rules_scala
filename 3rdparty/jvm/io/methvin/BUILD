load("//rules:bazel_deps.bzl", "scala_import")

java_library(
    name = "directory_watcher",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        "//3rdparty/jvm/com/google/guava",
        "//3rdparty/jvm/org/slf4j:slf4j_api",
        "//external:jar/scala_annex_io/methvin/directory_watcher",
    ],
)

java_library(
    name = "directory_watcher_better_files_2_12",
    visibility = [
        "//visibility:public",
    ],
    exports = [
        ":directory_watcher",
        "//3rdparty/jvm/com/github/pathikrit:better_files_2_12",
        "//external:jar/scala_annex_io/methvin/directory_watcher_better_files_2_12",
    ],
)
