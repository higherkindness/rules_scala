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
    _bootstrap_scala_binary_implementation = "bootstrap_scala_binary_implementation",
    _bootstrap_scala_binary_private_attributes = "bootstrap_scala_binary_private_attributes",
    _bootstrap_scala_library_implementation = "bootstrap_scala_library_implementation",
    _bootstrap_scala_library_private_attributes = "bootstrap_scala_library_private_attributes",
    _scala_binary_implementation = "scala_binary_implementation",
    _scala_binary_private_attributes = "scala_binary_private_attributes",
    _scala_library_implementation = "scala_library_implementation",
    _scala_library_private_attributes = "scala_library_private_attributes",
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

_library_common_attributes = {
    "srcs": attr.label_list(
        doc = "The source Scala and Java files (and `.srcjar` files of those).",
        allow_files = [
            ".scala",
            ".java",
            ".srcjar",
        ],
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
        providers = [
            _ScalaConfiguration,
            #_ZincConfiguration,
        ],
    ),
    "scalacopts": attr.string_list(
        doc = "The Scalac options.",
    ),
}

scala_library = rule(
    attrs = _dicts.add(
        _library_common_attributes,
        _scala_library_private_attributes,
    ),
    doc = "Compiles a Scala JVM library.",
    outputs = {
        "jar": "%{name}.jar",
    },
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    implementation = _scala_library_implementation,
)

bootstrap_scala_library = rule(
    attrs = _dicts.add(
        _library_common_attributes,
        _bootstrap_scala_library_private_attributes,
    ),
    doc = "Compiles a Scala JVM library.",
    outputs = {
        "jar": "%{name}.jar",
    },
    implementation = _bootstrap_scala_library_implementation,
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
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
        "jar": "%{name}.jar",
        "deploy_jar": "%{name}_deploy.jar",
    },
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    implementation = _scala_binary_implementation,
)

bootstrap_scala_binary = rule(
    attrs = _dicts.add(
        _library_common_attributes,
        _runner_common_attributes,
        _bootstrap_scala_binary_private_attributes,
        {
            "main_class": attr.string(
                mandatory = True,
            ),
        },
    ),
    doc = "Compiles and links a Scala JVM executable.",
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
        "jar": "%{name}.jar",
        "deploy_jar": "%{name}_deploy.jar",
    },
    implementation = _bootstrap_scala_binary_implementation,
)

scala_test = rule(
    attrs = _dicts.add(
        _library_common_attributes,
        _runner_common_attributes,
        _scala_test_private_attributes,
        {
            "isolation": attr.string(
                default = "none",
                doc = "The isolation level to apply",
                values = [
                    "classloader",
                    "none",
                    "process",
                ],
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
                    "com.novocode.junit.JUnitFramework",
                ],
            ),
            "runner": attr.label(default = "@rules_scala_annex//rules/scala:test"),
            "subprocess_runner": attr.label(default = "@rules_scala_annex//rules/scala:test_subprocess"),
        },
    ),
    executable = True,
    outputs = {
        "bin": "%{name}-bin",
        "jar": "%{name}.jar",
    },
    test = True,
    toolchains = [
        "@rules_scala_annex//rules/scala:deps_toolchain_type",
        "@rules_scala_annex//rules/scala:runner_toolchain_type",
    ],
    implementation = _scala_test_implementation,
)

# scala_repl

scala_repl = rule(
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
                providers = [
                    _ScalaConfiguration,
                    _ZincConfiguration,
                ],
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
    implementation = _scala_repl_implementation,
)

scala_import = rule(
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
    implementation = _scala_import_implementation,
)

scaladoc = rule(
    attrs = _dicts.add(
        _scaladoc_private_attributes,
        {
            "compiler_deps": attr.label_list(providers = [JavaInfo]),
            "deps": attr.label_list(providers = [JavaInfo]),
            "srcs": attr.label_list(allow_files = [
                ".java",
                ".scala",
                ".srcjar",
            ]),
            "scala": attr.label(
                default = "@scala",
                providers = [
                    _ScalaConfiguration,
                    _ZincConfiguration,
                ],
            ),
            "scalacopts": attr.string_list(),
            "title": attr.string(),
        },
    ),
    doc = """
Generates Scaladocs.
""",
    implementation = _scaladoc_implementation,
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
    implementation = _scala_runner_toolchain_implementation,
)

# scala_deps_toolchain

def scala_deps_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        direct = ctx.attr.direct,
        runner = ctx.attr.runner,
        used = ctx.attr.used,
    )]

scala_deps_toolchain = rule(
    attrs = {
        "direct": attr.string(),
        "runner": attr.label(
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "used": attr.string(),
    },
    doc = "Configures the deps checker and options to use.",
    implementation = scala_deps_toolchain_implementation,
)

configure_basic_scala = rule(
    attrs = {
        "version": attr.string(mandatory = True),
        "compiler_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "runtime_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "global_plugins": attr.label_list(
            doc = "Scalac plugins that will always be enabled.",
            providers = [JavaInfo],
        ),
    },
    implementation = _configure_basic_scala_implementation,
)

configure_scala = rule(
    attrs = {
        "version": attr.string(mandatory = True),
        "runtime_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "compiler_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "compiler_bridge": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
        "global_plugins": attr.label_list(
            doc = "Scalac plugins that will always be enabled.",
            providers = [JavaInfo],
        ),
    },
    implementation = _configure_scala_implementation,
)
