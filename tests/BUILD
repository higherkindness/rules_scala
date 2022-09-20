java_runtime(
    name = "jdk",
    srcs = select({
        "@bazel_tools//src/conditions:linux_x86_64": ["@jdk11-linux//:jdk"],
        "@bazel_tools//src/conditions:darwin_x86_64": ["@jdk11-osx//:jdk"],
    }),
    java = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@jdk11-linux//:java",
        "@bazel_tools//src/conditions:darwin_x86_64": "@jdk11-osx//:java",
    }),
    visibility = ["//visibility:public"],
)
