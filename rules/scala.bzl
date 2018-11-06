##
## top level rules
##

load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")
load(
    "@rules_scala_annex//rules:jvm.bzl",
    _labeled_jars = "labeled_jars",
)
load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ZincConfiguration = "ZincConfiguration",
)
load(
    "//rules/scala:private/core.bzl",
    _scala_library_implementation = "scala_library_implementation",
    _scala_library_private_attributes = "scala_library_private_attributes",
    _scala_binary_implementation = "scala_binary_implementation",
    _scala_binary_private_attributes = "scala_binary_private_attributes",
    _scala_test_implementation = "scala_test_implementation",
    _scala_test_private_attributes = "scala_test_private_attributes",
)
load(
    "//rules/scala:private/doc.bzl",
    _scaladoc_implementation = "scaladoc_implementation",
    _scaladoc_private_attributes = "scaladoc_private_attributes",
)
load(
    "//rules/scala:private/import.bzl",
    _scala_import_implementation = "scala_import_implementation",
    _scala_import_private_attributes = "scala_import_private_attributes",
)
load(
    "//rules/scala:private/provider.bzl",
    _configure_basic_scala_implementation = "configure_basic_scala_implementation",
    _configure_scala_implementation = "configure_scala_implementation",
)
load(
    "//rules/scala:private/repl.bzl",
    _scala_repl_implementation = "scala_repl_implementation",
    _scala_repl_private_attributes = "scala_repl_private_attributes",
)
load(
    "//rules:scalac.bzl",
    _scalac_library = "scalac_library",
)

_library_common_attributes = {
    "srcs": attr.label_list(
        doc = "The source Scala and Java files (and `.srcjar` files of those).",
        allow_files = [".scala", ".java", ".srcjar"],
    ),
    "data": attr.label_list(
        doc = "The additional runtime files needed by this library.",
        allow_files = True,
        cfg = "data",
    ),
    "deps": attr.label_list(
        aspects = [_labeled_jars],
        doc = "The JVM library dependencies.",
        providers = [JavaInfo],
    ),
    "deps_used_whitelist": attr.label_list(
        doc = "The JVM library dependencies to always consider used for `scala_deps_used` checks.",
        providers = [JavaInfo],
    ),
    "exports": attr.label_list(
        doc = "The JVM libraries to add as dependencies to any libraries dependent on this one.",
        providers = [JavaInfo],
    ),
    "runtime_deps": attr.label_list(
        doc = "The JVM runtime-only library dependencies.",
        providers = [JavaInfo],
    ),
    "javacopts": attr.string_list(
        doc = "The Javac options.",
    ),
    "macro": attr.bool(
        default = False,
        doc = "Whether this library provides macros.",
    ),
    "neverlink": attr.bool(
        default = False,
        doc = "Whether this library should be excluded at runtime.",
    ),
    "plugins": attr.label_list(
        doc = "The Scalac plugins.",
        providers = [JavaInfo],
    ),
    "resource_strip_prefix": attr.string(
        doc = "The path prefix to strip from classpath resources.",
    ),
    "resources": attr.label_list(
        allow_files = True,
        doc = "The files to include as classpath resources.",
    ),
    "resource_jars": attr.label_list(
        allow_files = [".jar"],
        doc = "The JARs to merge into the output JAR.",
    ),
    "scala": attr.label(
        default = "@scala",
        doc = "The `ScalaConfiguration`.",
        providers = [_ScalaConfiguration, _ZincConfiguration],
    ),
    "scalacopts": attr.string_list(
        doc = "The Scalac options.",
    ),
}

scala_library = rule(
    implementation = _scala_library_implementation,
    attrs = _dicts.add(
        _library_common_attributes,
        _scala_library_private_attributes,
    ),
    doc = "Compiles a Scala JVM library.",
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    outputs = {
        "jar": "%{name}.jar",
    },
)

_runner_common_attributes = {
    "jvm_flags": attr.string_list(
        doc = "The JVM runtime flags.",
    ),
    "runtime_deps": attr.label_list(
        doc = "The JVM runtime-only library dependencies.",
        providers = [JavaInfo],
    ),
}

scala_binary = rule(
    implementation = _scala_binary_implementation,
    attrs = _dicts.add(
        _library_common_attributes,
        _runner_common_attributes,
        _scala_binary_private_attributes,
        {
            "main_class": attr.string(
                doc = "The main class. If not provided, it will be inferred by its type signature.",
            ),
        },
    ),
    doc = "Compiles and links a Scala JVM executable.",
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
        "jar": "%{name}.jar",
        "deploy_jar": "%{name}_deploy.jar",
    },
)

scala_test = rule(
    implementation = _scala_test_implementation,
    attrs = _dicts.add(
        _library_common_attributes,
        _runner_common_attributes,
        _scala_test_private_attributes,
        {
            "isolation": attr.string(
                default = "none",
                doc = "The isolation level to apply",
                values = ["classloader", "none", "process"],
            ),
            "scalacopts": attr.string_list(),
            "shared_deps": attr.label_list(
                doc = "If isolation is \"classloader\", the list of deps to keep loaded between tests",
                providers = [JavaInfo],
            ),
            "frameworks": attr.string_list(
                default = [
                    "org.scalatest.tools.Framework",
                    "org.scalacheck.ScalaCheckFramework",
                    "org.specs2.runner.Specs2Framework",
                    "minitest.runner.Framework",
                    "utest.runner.Framework",
                ],
            ),
            "runner": attr.label(default = "@rules_scala_annex//rules/scala:test"),
            "subprocess_runner": attr.label(default = "@rules_scala_annex//rules/scala:test_subprocess"),
        },
    ),
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    test = True,
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
        "jar": "%{name}.jar",
    },
)

# scala_repl

scala_repl = rule(
    implementation = _scala_repl_implementation,
    attrs = _dicts.add(
        _scala_repl_private_attributes,
        {
            "data": attr.label_list(
                doc = "The additional runtime files needed by this REPL.",
                allow_files = True,
                cfg = "data",
            ),
            "deps": attr.label_list(providers = [JavaInfo]),
            "jvm_flags": attr.string_list(
                doc = "The JVM runtime flags.",
            ),
            "scala": attr.label(
                default = "@scala",
                doc = "The `ScalaConfiguration`.",
                providers = [_ScalaConfiguration, _ZincConfiguration],
            ),
            "scalacopts": attr.string_list(
                doc = "The Scalac options.",
            ),
        },
    ),
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
    },
)

scala_import = rule(
    implementation = _scala_import_implementation,
    attrs = _dicts.add(
        _scala_import_private_attributes,
        {
            "deps": attr.label_list(providers = [JavaInfo]),
            "exports": attr.label_list(providers = [JavaInfo]),
            "jars": attr.label_list(allow_files = True),
            "neverlink": attr.bool(default = False),
            "runtime_deps": attr.label_list(providers = [JavaInfo]),
            "srcjar": attr.label(allow_single_file = True),
        },
    ),
    doc = """
Creates a Scala JVM library.

Use this only for libraries with macros. Otherwise, use `java_import`.
""",
)

scaladoc = rule(
    implementation = _scaladoc_implementation,
    attrs = _dicts.add(
        _scaladoc_private_attributes,
        {
            "compiler_deps": attr.label_list(providers = [JavaInfo]),
            "deps": attr.label_list(providers = [JavaInfo]),
            "srcs": attr.label_list(allow_files = [".java", ".scala", ".srcjar"]),
            "scala": attr.label(
                default = "@scala",
                providers = [_ScalaConfiguration, _ZincConfiguration],
            ),
            "scalacopts": attr.string_list(),
            "title": attr.string(),
        },
    ),
    doc = """
Generates Scaladocs.
""",
)

##
## core/underlying rules and configuration ##
##

# scala_runner_toolchain

def _scala_runner_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        runner = ctx.attr.runner,
        scalacopts = ctx.attr.scalacopts,
        encoding = ctx.attr.encoding,
    )]

scala_runner_toolchain = rule(
    implementation = _scala_runner_toolchain_implementation,
    attrs = {
        "runner": attr.label(
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "scalacopts": attr.string_list(),
        "encoding": attr.string(),
    },
    doc = "Configures the Scala runner to use.",
)

# scala_deps_toolchain

def scala_deps_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        direct = ctx.attr.direct,
        runner = ctx.attr.runner,
        used = ctx.attr.used,
    )]

scala_deps_toolchain = rule(
    implementation = scala_deps_toolchain_implementation,
    attrs = {
        "direct": attr.string(),
        "runner": attr.label(allow_files = True, executable = True, cfg = "host"),
        "used": attr.string(),
    },
    doc = "Configures the deps checker and options to use.",
)

_configure_basic_scala = rule(
    implementation = _configure_basic_scala_implementation,
    attrs = {
        "compiler_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "runtime_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "version": attr.string(mandatory = True),
    },
)

_configure_scala = rule(
    implementation = _configure_scala_implementation,
    attrs = {
        "version": attr.string(mandatory = True),
        "runtime_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "compiler_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "compiler_bridge": attr.label(allow_single_file = True, mandatory = True),
    },
)

"""
Configures a Scala provider for use by library, binary, and test rules.

Args:

  version:
    The full Scala version string, such as "2.12.5"

  runtime_classpath:
    The full Scala runtime classpath for use in library, binary, and test rules;
    i.e. scala-library + scala-reflect + ...

  compiler_classpath:
    The full Scala compiler classpath required to invoke the Scala compiler;
    i.e.. scala-compiler + scala-library +  scala-reflect + ...

  compiler_bridge:
    The Zinc compiler bridge with attached sources.

"""

def configure_scala(
        name,
        compiler_bridge,
        compiler_bridge_classpath,
        compiler_classpath,
        **kwargs):
    _configure_basic_scala(name = "{}_basic".format(name), compiler_classpath = compiler_classpath, **kwargs)

    _scalac_library(
        name = "{}_compiler_bridge".format(name),
        deps = compiler_classpath + compiler_bridge_classpath,
        scala = ":{}_basic".format(name),
        srcs = [compiler_bridge],
    )

    _configure_scala(name = name, compiler_bridge = ":{}_compiler_bridge".format(name), compiler_classpath = compiler_classpath, **kwargs)
