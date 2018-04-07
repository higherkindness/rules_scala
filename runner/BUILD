load(":build.bzl", "basic_scala_binary")

basic_scala_binary(
    name = "runner",
    scala = "@scalas//:scala_2_12_4",
    srcs = glob(["src/main/scala/**/*.scala"]),
    main_class = 'annex.AnxWorker',
    deps = [
         '//third_party/bazel/src/main/protobuf:worker_protocol_java_proto',
         '//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper',
         '//3rdparty/jvm/org/scala_sbt:zinc_2_12',
         '//3rdparty/jvm/org/scala_sbt:zinc_apiinfo_2_12',
         '//3rdparty/jvm/org/scala_sbt:zinc_core_2_12',
         '//3rdparty/jvm/org/scala_sbt:zinc_compile_core_2_12',
         '//3rdparty/jvm/org/scala_sbt:util_control_2_12',
         '//3rdparty/jvm/org/scala_sbt:util_logging_2_12',
         '//3rdparty/jvm/org/scala_sbt:util_interface',
         '//3rdparty/jvm/org/scala_sbt:test_interface',
         '//3rdparty/jvm/org/scala_sbt:compiler_interface',
    ],
    visibility = ["//visibility:public"],
)
