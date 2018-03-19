load(":build.bzl", "basic_scala_binary")

basic_scala_binary(
    name = "runner",
    scala = "@scalas//:scala_2_12_4",
    srcs = glob(["src/main/scala/**/*.scala"]),
    main_class = 'annex.ZincRunner',
    deps = [
         '@compiler_interface//jar',
         '@util_interface//jar',
         '//3rdparty/jvm/org/scala_sbt:zinc_2_12',
         '//3rdparty/jvm/org/scala_sbt:zinc_compile_core_2_12',         
    ],
    visibility = ["//visibility:public"],
)
