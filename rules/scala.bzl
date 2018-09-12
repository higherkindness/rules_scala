##
## top level rules
##

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

# scala_library

"""
Compiles and links Scala/Java sources into a .jar file.

Args:

  srcs:
    The list of source files that are processed to create the target.

  deps:
    The list of libraries to link into this library. Deps can include
    standard Java libraries as well as cross compiled Scala libraries.

  scala:
    ScalaConfiguration(s) to use for compiling sources.

"""
scala_library = rule(
    implementation = _scala_library_implementation,
    attrs = dict({
        "srcs": attr.label_list(allow_files = [".scala", ".java", ".srcjar"]),
        "data": attr.label_list(allow_files = True, cfg = "data"),
        "deps": attr.label_list(aspects = [_labeled_jars], providers = [JavaInfo]),
        "deps_used_whitelist": attr.label_list(),
        "runtime_deps": attr.label_list(providers = [JavaInfo]),
        "exports": attr.label_list(providers = [JavaInfo]),
        "javacopts": attr.string_list(),
        "macro": attr.bool(default = False),
        "neverlink": attr.bool(default = False),
        "scala": attr.label(
            default = "@scala",
            providers = [_ScalaConfiguration, _ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "plugins": attr.label_list(providers = [JavaInfo]),
        "resource_strip_prefix": attr.string(),
        "resources": attr.label_list(allow_files = True),
        "resource_jars": attr.label_list(allow_files = [".jar"]),
    }, **_scala_library_private_attributes),
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    outputs = {
        "jar": "%{name}.jar",
    },
)

annex_scala_library = scala_library

# scala_binary

scala_binary = rule(
    implementation = _scala_binary_implementation,
    attrs = dict({
        "srcs": attr.label_list(allow_files = [".scala", ".java", ".srcjar"]),
        "data": attr.label_list(allow_files = True, cfg = "data"),
        "deps": attr.label_list(aspects = [_labeled_jars], providers = [JavaInfo]),
        "deps_used_whitelist": attr.label_list(),
        "javacopts": attr.string_list(),
        "jvm_flags": attr.string_list(),
        "runtime_deps": attr.label_list(providers = [JavaInfo]),
        "exports": attr.label_list(providers = [JavaInfo]),
        "macro": attr.bool(default = False),
        "main_class": attr.string(),
        "scala": attr.label(
            default = "@scala",
            providers = [_ScalaConfiguration, _ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "plugins": attr.label_list(providers = [JavaInfo]),
        "resource_strip_prefix": attr.string(),
        "resources": attr.label_list(allow_files = True),
        "resource_jars": attr.label_list(allow_files = [".jar"]),
    }, **_scala_binary_private_attributes),
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
        "jar": "%{name}.jar",
    },
)

annex_scala_binary = scala_binary

# scala_test

scala_test = rule(
    implementation = _scala_test_implementation,
    attrs = dict({
        "srcs": attr.label_list(allow_files = [".scala", ".java", ".srcjar"]),
        "data": attr.label_list(allow_files = True, cfg = "data"),
        "deps": attr.label_list(aspects = [_labeled_jars], providers = [JavaInfo]),
        "deps_used_whitelist": attr.label_list(),
        "javacopts": attr.string_list(),
        "jvm_flags": attr.string_list(),
        "runtime_deps": attr.label_list(providers = [JavaInfo]),
        "exports": attr.label_list(providers = [JavaInfo]),
        "macro": attr.bool(default = False),
        "scala": attr.label(
            default = "@scala",
            providers = [_ScalaConfiguration, _ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "plugins": attr.label_list(providers = [JavaInfo]),
        "frameworks": attr.string_list(
            default = [
                "org.scalatest.tools.Framework",
                "org.scalacheck.ScalaCheckFramework",
                "org.specs2.runner.Specs2Framework",
                "minitest.runner.Framework",
                "utest.runner.Framework",
            ],
        ),
        "resource_strip_prefix": attr.string(),
        "resources": attr.label_list(allow_files = True),
        "resource_jars": attr.label_list(allow_files = [".jar"]),
        "runner": attr.label(default = "@rules_scala_annex//rules/scala:test"),
    }, **_scala_test_private_attributes),
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

annex_scala_test = scala_test

# scala_repl

scala_repl = rule(
    implementation = _scala_repl_implementation,
    attrs = dict({
        "data": attr.label_list(allow_files = True, cfg = "data"),
        "deps": attr.label_list(providers = [JavaInfo]),
        "jvm_flags": attr.string_list(),
        "scala": attr.label(default = "@scala", providers = [_ScalaConfiguration, _ZincConfiguration]),
        "scalacopts": attr.string_list(),
    }, **_scala_repl_private_attributes),
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
    },
)

# scala_import

"""
scala_import for use with bazel-deps
"""
scala_import = rule(
    implementation = _scala_import_implementation,
    attrs = dict({
        "jars": attr.label_list(allow_files = True),
	"srcjar": attr.label(allow_single_file = True),
        "deps": attr.label_list(providers = [JavaInfo]),
        "neverlink": attr.bool(default = False),
        "runtime_deps": attr.label_list(providers = [JavaInfo]),
        "exports": attr.label_list(providers = [JavaInfo]),
    }, **_scala_import_private_attributes),
)

# scaladoc

scaladoc = rule(
    implementation = _scaladoc_implementation,
    attrs = dict({
        "compiler_deps": attr.label_list(providers = [JavaInfo]),
        "deps": attr.label_list(providers = [JavaInfo]),
        "srcs": attr.label_list(allow_files = [".java", ".scala", ".srcjar"]),
        "scala": attr.label(
            default = "@scala",
            providers = [_ScalaConfiguration, _ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "title": attr.string(),
    }, **_scaladoc_private_attributes),
)

##
## core/underlying rules and configuration ##
##

# scala_runner_toolchain

def _scala_runner_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        runner = ctx.attr.runner,
        scalacopts = ctx.attr.scalacopts,
    )]

"""
Configures which Scala runner to use
"""
scala_runner_toolchain = rule(
    implementation = _scala_runner_toolchain_implementation,
    attrs = {
        "runner": attr.label(
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "scalacopts": attr.string_list(),
    },
)

annex_scala_runner_toolchain = scala_runner_toolchain

# scala_deps_toolchain

def _annex_scala_deps_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        direct = ctx.attr.direct,
        runner = ctx.attr.runner,
        used = ctx.attr.used,
    )]

"""
Configures the deps checker and options to use
"""
annex_scala_deps_toolchain = rule(
    implementation = _annex_scala_deps_toolchain_implementation,
    attrs = {
        "direct": attr.string(),
        "runner": attr.label(allow_files = True, executable = True, cfg = "host"),
        "used": attr.string(),
    },
)

_annex_configure_basic_scala = rule(
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
    _annex_configure_basic_scala(name = "{}_basic".format(name), compiler_classpath = compiler_classpath, **kwargs)

    _scalac_library(
        name = "{}_compiler_bridge".format(name),
        deps = compiler_classpath + compiler_bridge_classpath,
        scala = ":{}_basic".format(name),
        srcs = [compiler_bridge],
    )

    _configure_scala(name = name, compiler_bridge = ":{}_compiler_bridge".format(name), compiler_classpath = compiler_classpath, **kwargs)

annex_configure_scala = configure_scala
