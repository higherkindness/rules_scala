load("//rules:scala.bzl", "scala_binary")
load("//rules:scalafmt.bzl", "scala_format_test")

scala_binary(
    name = "compile",
    srcs = glob(["**/*.scala"]),
    main_class = "higherkindness.rules_scala.workers.zinc.compile.ZincRunner",
    scala = "//src/main/scala:bootstrap",
    visibility = ["//visibility:public"],
    runtime_deps = [
        "@annex//:com_lihaoyi_sourcecode_2_13",
        # This is kind of hacky, but as far as I can tell there
        # are no classpath issues with always having some of the
        # Scala 3 stuff on the classpath at runtime
        # It works with either a bootstrap 2 or 3 compiler for
        # compiling either 2 or 3
        # TODO: do I need this?
        #"@annex_3//:org_scala_lang_scala3_interfaces",
        #"@annex_3//:org_scala_lang_tasty_core_3",
    ],
    deps = [
        "//src/main/scala/higherkindness/rules_scala/common/worker",
        "//src/main/scala/higherkindness/rules_scala/workers/common",
        "//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper",
    ],
)

scala_format_test(
    name = "format",
    srcs = glob(["**/*.scala"]),
)
