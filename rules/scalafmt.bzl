load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load(
    "//rules/scalafmt:private/test.bzl",
    _scala_format_test_implementation =
        "scala_format_test_implementation",
    _scala_format_private_attributes =
        "scala_format_private_attributes",
)

"""
Formats and checks the format of Scala.

See [scalafmt.md](../scalafmt.md)
"""
scala_format_test = rule(
    implementation = _scala_format_test_implementation,
    attrs = _dicts.add(
        _scala_format_private_attributes,
        {
            "config": attr.label(
                allow_single_file = [".conf"],
                default = "@scalafmt_default//:config",
                doc = "The Scalafmt configuration file.",
            ),
            "srcs": attr.label_list(
                allow_files = [".scala"],
                doc = "The Scala files.",
            ),
        },
    ),
    test = True,
    toolchains = ["@rules_scala_annex//rules/scala:runner_toolchain_type"],
    outputs = {
        "runner": "%{name}-format",
    },
)
