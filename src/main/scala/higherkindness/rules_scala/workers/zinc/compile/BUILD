load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "compile",
    srcs = glob(["**/*.scala"]),
    main_class = "higherkindness.rules_scala.workers.zinc.compile.ZincRunner",
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@scala_annex_com_lihaoyi_sourcecode_2_12",
    ],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "//src/main/scala/higherkindness/rules_scala/workers/zinc/common",
        "//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
        "@scala_annex_org_scala_sbt_test_interface",
        "@scala_annex_org_scala_sbt_zinc_2_12",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
