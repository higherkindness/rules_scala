java_runtime(
    name = "jdk",
    srcs = select({
        "@bazel_tools//src/conditions:linux_x86_64": ["@jdk8-linux//:jdk"],
        "@bazel_tools//src/conditions:darwin_x86_64": ["@jdk8-osx//:jdk"],
        "@bazel_tools//src/conditions:darwin": ["@jdk8-osx//:jdk"],
    }),
    java = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@jdk8-linux//:java",
        "@bazel_tools//src/conditions:darwin_x86_64": "@jdk8-osx//:java",
        "@bazel_tools//src/conditions:darwin": "@jdk8-osx//:java",
    }),
    visibility = ["//visibility:public"],
)
