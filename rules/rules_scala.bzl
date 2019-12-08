load(
    "//rules/common:private/utils.bzl",
    _strip_margin = "strip_margin",
)

def _emulate_rules_scala_repository_impl(repository_ctx):
    repository_ctx.file("WORKSPACE", content = "workspace(name = \"io_bazel_rules_scala\")")
    repository_ctx.file(
        "scala/scala.bzl",
        content = _strip_margin("""
          |load("@rules_scala_annex//rules/rules_scala:private/compat.bzl",
          |     _scala_library = "scala_library",
          |     _scala_macro_library = "scala_macro_library",
          |     _scala_binary = "scala_binary",
          |     _scala_test = "scala_test",
          |     _scala_test_suite = "scala_test_suite",
          |)
          |
          |scala_library = _scala_library
          |scala_macro_library = _scala_macro_library
          |scala_binary = _scala_binary
          |scala_test = _scala_test
          |scala_test_suite = _scala_test_suite
          |"""),
    )
    repository_ctx.file(
        "scala/scala_import.bzl",
        content = _strip_margin("""
          |load("@rules_scala_annex//rules:scala.bzl",
          |     _scala_import = "scala_import",
          |)
          |
          |scala_import = _scala_import
          |"""),
    )
    extra_deps = ", ".join(["\"{}\"".format(dep) for dep in repository_ctx.attr.extra_deps])
    repository_ctx.file(
        "scala/BUILD",
        content = _strip_margin("""
          |java_import(
          |    name = "extra_deps",
          |    exports = [
          |        {extra_deps}
          |    ],
          |    jars = [],
          |    visibility = ["//visibility:public"],
          |)
          |""".format(extra_deps = extra_deps)),
    )

emulate_rules_scala_repository = repository_rule(
    attrs = {
        "extra_deps": attr.label_list(default = []),
    },
    local = True,
    implementation = _emulate_rules_scala_repository_impl,
)

def emulate_rules_scala(scala, scalatest, extra_deps = []):
    native.bind(
        name = "scala_annex/compat/rules_scala/scala",
        actual = scala,
    )

    native.bind(
        name = "scala_annex/compat/rules_scala/extra_deps",
        actual = "@io_bazel_rules_scala//scala:extra_deps",
    )

    native.bind(
        name = "scala_annex/compat/rules_scala/scalatest_dep",
        actual = scalatest,
    )

    emulate_rules_scala_repository(
        name = "io_bazel_rules_scala",
        extra_deps = extra_deps,
    )
