load(
    "@rules_scala_annex//rules:internal/bazel_deps_internal.bzl",
    "scala_import_implementation",
)

"""
scala_import for use with bazel-deps
"""

scala_import = rule(
    implementation = scala_import_implementation,
    attrs = {
        "jars": attr.label_list(allow_files = True),
        "deps": attr.label_list(),
        "runtime_deps": attr.label_list(),
        "exports": attr.label_list(),
    },
)
