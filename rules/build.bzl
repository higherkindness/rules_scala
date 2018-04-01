load("@scala_annex//rules:internal/build_internal.bzl",
     "annex_configure_scala_implementation",
     "annex_configure_scala_private_attributes",
     "annex_configure_scala_testing_framework_implementation",
     "annex_scala_library_implementation",
     "annex_scala_library_private_attributes",
     "annex_scala_binary_implementation",
     "annex_scala_binary_private_attributes",
     "annex_scala_test_implementation",
     "annex_scala_test_private_attributes",
)

load("@scala_annex//rules:providers.bzl",
     "ScalaConfiguration",
     "ScalaTestingFramework",
)

load("@scala_annex//rules:internal/utils.bzl", utils = "root")

annex_configure_scala = rule(
    implementation = annex_configure_scala_implementation,
    attrs = utils.merge_dicts(annex_configure_scala_private_attributes, {
        'version': attr.string(),
        'binary_version': attr.string(),
        'compiler_classpath': attr.label_list(allow_files = True),
        'compiler_bridge': attr.label(allow_files = True),
        'compiler_bridge_classpath': attr.label_list(allow_files = True),
        'runtime_classpath': attr.label_list(allow_files = True),
    }),
)

annex_configure_scala_testing_framework = rule(
    implementation = annex_configure_scala_testing_framework_implementation,
    attrs = {
        'framework_class': attr.string(mandatory = True),
    },
)

def annex_configure_scala_testing_frameworks(**entries):
    for name, framework_class in entries.items():
        annex_configure_scala_testing_framework(
            name = name,
            framework_class = framework_class)

annex_scala_library = rule(
    implementation = annex_scala_library_implementation,
    attrs = utils.merge_dicts(annex_scala_library_private_attributes, {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "scala": attr.label_list(
            mandatory = True,
            providers = [ScalaConfiguration]),
    }),
    outputs = {},
)

annex_scala_binary = rule(
    implementation = annex_scala_binary_implementation,
    attrs = utils.merge_dicts(annex_scala_binary_private_attributes, {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "scala": attr.label_list(
            mandatory = True,
            providers = [ScalaConfiguration]),
    }),
    executable = True,
    outputs = {},
)

annex_scala_test = rule(
    implementation = annex_scala_test_implementation,
    attrs = utils.merge_dicts(annex_scala_test_private_attributes, {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "scala": attr.label_list(
            mandatory = True,
            providers = [ScalaConfiguration]),
        "frameworks": attr.string_list(
            default = [
                "org.scalatest.tools.Framework",
                "org.scalacheck.ScalaCheckFramework",
                "org.specs2.runner.Specs2Framework",
                "minitest.runner.Framework",
                "utest.runner.Framework",
            ]),
    }),
    test = True,
    executable = True,
    outputs = {},
)
