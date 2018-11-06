"""
Rules for invoking scalac directly.
"""

load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
)
load(
    "//rules/scalac:private.bzl",
    _scalac_library_implementation = "scalac_library_implementation",
    _scalac_library_private_attributes = "scalac_library_private_attributes",
    _scalac_binary_implementation = "scalac_binary_implementation",
    _scalac_binary_private_attributes = "scalac_binary_private_attributes",
)

scalac_library = rule(
    doc = """
Compiles a Scala JVM library.

This is a low-level rule used to bootstrap higher-level rules.
You probably don't want to use this directly.
""",
    implementation = _scalac_library_implementation,
    attrs = _dicts.add(
        _scalac_library_private_attributes,
        {
            "srcs": attr.label_list(
                allow_files = [".scala", ".java", ".srcjar"],
                doc = "The source Scala and Java files (and `.srcjar` files of those).",
            ),
            "deps": attr.label_list(
                doc = "The JVM library dependencies.",
                providers = [JavaInfo],
            ),
            "macro": attr.bool(
                doc = "Whether this library provides macros.",
                default = False,
            ),
            "runtime_deps": attr.label_list(
                doc = "The JVM runtime-only library dependencies.",
                providers = [JavaInfo],
            ),
            "scala": attr.label(
                doc = "The `ScalaConfiguration`.",
                mandatory = True,
                providers = [_ScalaConfiguration],
            ),
        },
    ),
)

scalac_binary = rule(
    doc = """
Compiles and link a Scala JVM executable.

This is a low-level rule used to bootstrap higher-level rules.
You probably don't want to use this directly.
""",
    implementation = _scalac_binary_implementation,
    attrs = _dicts.add(
        _scalac_binary_private_attributes,
        {
            "srcs": attr.label_list(
                allow_files = [".scala", ".java", ".srcjar"],
                doc = "The source Scala and Java files (and `.srcjar` files of those).",
            ),
            "deps": attr.label_list(
                doc = "The JVM library dependencies.",
                providers = [JavaInfo],
            ),
            "macro": attr.bool(
                default = False,
                doc = "Whether this library provides macros.",
            ),
            "runtime_deps": attr.label_list(
                doc = "The JVM runtime-only library dependencies.",
                providers = [JavaInfo],
            ),
            "main_class": attr.string(
                doc = "The main class.",
                mandatory = True,
            ),
            "scala": attr.label(
                doc = "The `ScalaConfiguration`.",
                mandatory = True,
                providers = [_ScalaConfiguration],
            ),
        },
    ),
    executable = True,
)
