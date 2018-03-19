load("@scala_annex//rules:internal/build_internal.bzl",
     "annex_configure_scala_implementation",
     "annex_scala_test_implementation",
     "annex_scala_test_private_attributes"
)

load("@scala_annex//rules:providers.bzl", "ScalaConfiguration")
load("@scala_annex//rules:internal/utils.bzl", utils = "root")

annex_configure_scala = rule(
    implementation = annex_configure_scala_implementation,
    attrs = {
        'version': attr.string(),
        'binary_version': attr.string(),
        'compiler_classpath': attr.label_list(allow_files = True),
        'compiler_bridge': attr.label(allow_files = True),
        'compiler_bridge_classpath': attr.label_list(allow_files = True),
        'runtime_classpath': attr.label_list(allow_files = True),
        "jar": attr.label(
            default = Label("@bazel_tools//tools/jdk:jar"),
            single_file = True,
        ),
        "java": attr.label(
            default = Label("@bazel_tools//tools/jdk:java"),
            single_file = True,
        ),
    },
)

annex_scala_test = rule(
    implementation = annex_scala_test_implementation,
    attrs = utils.merge_dicts(annex_scala_test_private_attributes, {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "scala": attr.label_list(
            mandatory=True,
            providers=[ScalaConfiguration]),
    }),
    outputs = {},
    executable = True,
    test = True,
    fragments = ["java"],
    toolchains = ['@io_bazel_rules_scala//scala:toolchain_type'],
)
