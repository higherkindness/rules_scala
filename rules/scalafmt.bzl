load("//rules/scalafmt:private/test.bzl", "annex_scala_format_test_implementation")

annex_scala_format_test = rule(
    implementation = annex_scala_format_test_implementation,
    attrs = {
        "_format": attr.label(
            cfg = "host",
            default = "@rules_scala_annex//rules/scalafmt",
            executable = True,
        ),
        "_runner": attr.label(
            allow_single_file = True,
            default = "@rules_scala_annex//rules/scalafmt:runner",
        ),
        "config": attr.label(allow_single_file = [".conf"], default = "@scalafmt_default//:config"),
        "srcs": attr.label_list(allow_files = [".scala"]),
    },
    test = True,
    outputs = {
        "runner": "%{name}-format",
    },
)
