load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load(
    "//rules/scalafmt:private/test.bzl",
    _scala_format_attributes = "scala_format_attributes",
    _scala_format_test_implementation = "scala_format_test_implementation",
)

"""
Formats and checks the format of Scala.

See [scalafmt.md](../scalafmt.md)
"""

scala_format_test = rule(
    attrs = _dicts.add(
        _scala_format_attributes,
        {
            "srcs": attr.label_list(
                allow_files = [".scala"],
                doc = "The Scala files.",
            ),
        },
    ),
    outputs = {
        "scalafmt_runner": "%{name}-format",
    },
    test = True,
    implementation = _scala_format_test_implementation,
)
