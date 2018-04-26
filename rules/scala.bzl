##
## top level rules
##

load("@rules_scala_annex//rules:jvm.bzl", "labeled_jars")
load(
    "@rules_scala_annex//rules:providers.bzl",
    "ScalaConfiguration",
    "ZincConfiguration",
)
load(
    "//rules/scala:private/binary.bzl",
    _annex_scala_binary_implementation = "annex_scala_binary_implementation",
    _annex_scala_binary_private_attributes = "annex_scala_binary_private_attributes",
)
load(
    "//rules/scala:private/library.bzl",
    _annex_scala_library_implementation = "annex_scala_library_implementation",
    _annex_scala_library_private_attributes = "annex_scala_library_private_attributes",
)
load(
    "//rules/scala:private/test.bzl",
    _annex_scala_test_implementation = "annex_scala_test_implementation",
    _annex_scala_test_private_attributes = "annex_scala_test_private_attributes",
)
load(
    "//rules/scala:private/import.bzl",
    _scala_import_implementation = "scala_import_implementation",
)
load(
    "//rules/scala:private/provider.bzl",
    _annex_configure_basic_scala_implementation = "annex_configure_basic_scala_implementation",
    _annex_configure_scala_implementation = "annex_configure_scala_implementation",
)
load(
    "//rules/scala:private/toolchain.bzl",
    _annex_scala_runner_toolchain_implementation = "annex_scala_runner_toolchain_implementation",
    _annex_scala_deps_toolchain_implementation = "annex_scala_deps_toolchain_implementation",
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
annex_scala_library = rule(
    implementation = _annex_scala_library_implementation,
    attrs = dict({
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(aspects = [labeled_jars]),
        "runtime_deps": attr.label_list(),
        "exports": attr.label_list(),
        "scala": attr.label(
            default = "@scala",
            providers = [ScalaConfiguration, ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "plugins": attr.label_list(),
        "use_ijar": attr.bool(default = True),
    }, **_annex_scala_library_private_attributes),
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    outputs = {
        "jar": "%{name}.jar",
    },
)

# scala_binary

annex_scala_binary = rule(
    implementation = _annex_scala_binary_implementation,
    attrs = dict({
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(aspects = [labeled_jars]),
        "runtime_deps": attr.label_list(),
        "exports": attr.label_list(),
        "main_class": attr.string(),
        "scala": attr.label(
            default = "@scala",
            providers = [ScalaConfiguration, ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "plugins": attr.label_list(),
        "use_ijar": attr.bool(default = True),
    }, **_annex_scala_binary_private_attributes),
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

# scala_test

annex_scala_test = rule(
    implementation = _annex_scala_test_implementation,
    attrs = dict({
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(aspects = [labeled_jars]),
        "runtime_deps": attr.label_list(),
        "exports": attr.label_list(),
        "scala": attr.label(
            default = "@scala",
            providers = [ScalaConfiguration, ZincConfiguration],
        ),
        "scalacopts": attr.string_list(),
        "plugins": attr.label_list(),
        "use_ijar": attr.bool(default = True),
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
    }, **_annex_scala_test_private_attributes),
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

# scala_import

"""
scala_import for use with bazel-deps
"""
scala_import = rule(
    implementation = _scala_import_implementation,
    attrs = {
        "jars": attr.label_list(allow_files = True),  #current hidden assumption is that these point to full, not ijar'd jars
        "srcjar": attr.label(allow_single_file = True),
        "deps": attr.label_list(),
        "runtime_deps": attr.label_list(),
        "exports": attr.label_list(),
    },
)

##
## core/underlying rules and configuration ##
##

# scala_runner_toolchain
# scala_deps_toolchain

"""
Configures which Scala runner to use
"""
annex_scala_runner_toolchain = rule(
    implementation = _annex_scala_runner_toolchain_implementation,
    attrs = {
        "runner": attr.label(
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "scalacopts": attr.string_list(),
    },
)

"""
Configures the deps checker and options to use
"""
annex_scala_deps_toolchain = rule(
    implementation = _annex_scala_deps_toolchain_implementation,
    attrs = {
        "flags": attr.string_list(default = []),
        "runner": attr.label(allow_files = True, executable = True, cfg = "host"),
    },
)

_annex_configure_basic_scala = rule(
    implementation = _annex_configure_basic_scala_implementation,
    attrs = {
        "compiler_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "runtime_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "version": attr.string(mandatory = True),
    },
)

_annex_configure_scala = rule(
    implementation = _annex_configure_scala_implementation,
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

def annex_configure_scala(
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

    _annex_configure_scala(name = name, compiler_bridge = ":{}_compiler_bridge".format(name), compiler_classpath = compiler_classpath, **kwargs)
