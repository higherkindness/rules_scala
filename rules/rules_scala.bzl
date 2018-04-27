load("//rules/common:private/utils.bzl", "strip_margin")

def _emulate_rules_scala_repository_impl(repository_ctx):
    repository_ctx.file("WORKSPACE", content = "")
    repository_ctx.file(
        "scala/scala.bzl",
        content = strip_margin("""
          |load("@rules_scala_annex//rules:rules_scala/private/compat.bzl",
          |     "scala_library",
          |     "scala_macro_library",
          |     "scala_binary",
          |     "scala_test",
          |     "scala_test_suite",
          |)
          |"""),
    )
    repository_ctx.file(
        "scala/scala_import.bzl",
        content = strip_margin("""
          |load("@rules_scala_annex//rules:scala.bzl",
          |     "scala_import",
          |)
          |"""),
    )
    repository_ctx.file("scala/BUILD", content = "")

emulate_rules_scala_repository = repository_rule(
    implementation = _emulate_rules_scala_repository_impl,
    local = True,
)

def emulate_rules_scala(scala, scalatest):
    native.bind(
        name = "scala_annex/compat/rules_scala/scala",
        actual = scala,
    )

    native.bind(
        name = "scala_annex/compat/rules_scala/scalatest_dep",
        actual = scalatest,
    )

    emulate_rules_scala_repository(name = "io_bazel_rules_scala")
