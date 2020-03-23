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
    _ScalaRulePhase = "ScalaRulePhase",
    _ZincConfiguration = "ZincConfiguration",
)
load(
    "@rules_scala_annex//rules/private:coverage_replacements_provider.bzl",
    _coverage_replacements_provider = "coverage_replacements_provider",
)
load(
    "//rules/private:phases.bzl",
    _adjust_phases = "adjust_phases",
    _phase_binary_deployjar = "phase_binary_deployjar",
    _phase_binary_launcher = "phase_binary_launcher",
    _phase_classpaths = "phase_classpaths",
    _phase_coda = "phase_coda",
    _phase_coverage_jacoco = "phase_coverage_jacoco",
    _phase_ijinfo = "phase_ijinfo",
    _phase_javainfo = "phase_javainfo",
    _phase_library_defaultinfo = "phase_library_defaultinfo",
    _phase_noop = "phase_noop",
    _phase_resources = "phase_resources",
    _phase_singlejar = "phase_singlejar",
    _phase_test_launcher = "phase_test_launcher",
    _run_phases = "run_phases",
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
    _configure_bootstrap_scala_implementation = "configure_bootstrap_scala_implementation",
    _configure_zinc_scala_implementation = "configure_zinc_scala_implementation",
)
load(
    "//rules/scala:private/repl.bzl",
    _scala_repl_implementation = "scala_repl_implementation",
)

_compile_private_attributes = {
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain"),
    ),
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        cfg = "host",
    ),
    "_singlejar": attr.label(
        cfg = "host",
        default = "@bazel_tools//tools/jdk:singlejar",
        executable = True,
    ),

    # TODO: push java and jar_creator into a provider for the
    # bootstrap compile phase
    "_jdk": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        providers = [java_common.JavaRuntimeInfo],
        cfg = "host",
    ),
    "_jar_creator": attr.label(
        default = Label("@rules_scala_annex//third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper:jarcreator_bin"),
        executable = True,
        cfg = "host",
    ),
}

_compile_attributes = {
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
    ),
    "deps": attr.label_list(
        aspects = [
            _labeled_jars,
            _coverage_replacements_provider.aspect,
        ],
        doc = "The JVM library dependencies.",
        providers = [JavaInfo],
    ),
    "deps_used_whitelist": attr.label_list(
        doc = "The JVM library dependencies to always consider used for `scala_deps_used` checks.",
        providers = [JavaInfo],
    ),
    "deps_unused_whitelist": attr.label_list(
        doc = "The JVM library dependencies to always consider unused for `scala_deps_direct` checks.",
        providers = [JavaInfo],
    ),
    "runtime_deps": attr.label_list(
        doc = "The JVM runtime-only library dependencies.",
        providers = [JavaInfo],
    ),
    "javacopts": attr.string_list(
        doc = "The Javac options.",
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
        default = "//external:default_scala",
        doc = "The `ScalaConfiguration`. Among other things, this specifies which scala version to use.\n Defaults to the default_scala target specified in the WORKSPACE file.",
        providers = [
            _ScalaConfiguration,
        ],
    ),
    "scalacopts": attr.string_list(
        doc = "The Scalac options.",
    ),
}

_library_attributes = {
    "exports": attr.label_list(
        aspects = [
            _coverage_replacements_provider.aspect,
        ],
        doc = "The JVM libraries to add as dependencies to any libraries dependent on this one.",
        providers = [JavaInfo],
    ),
    "macro": attr.bool(
        default = False,
        doc = "Whether this library provides macros.",
    ),
    "neverlink": attr.bool(
        default = False,
        doc = "Whether this library should be excluded at runtime.",
    ),
}

_runtime_attributes = {
    "jvm_flags": attr.string_list(
        doc = "The JVM runtime flags.",
    ),
    "runtime_deps": attr.label_list(
        doc = "The JVM runtime-only library dependencies.",
        providers = [JavaInfo],
    ),
}

_runtime_private_attributes = {
    "_target_jdk": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        providers = [java_common.JavaRuntimeInfo],
    ),
    "_java_stub_template": attr.label(
        default = Label("@anx_java_stub_template//file"),
        allow_single_file = True,
    ),
}

_testing_private_attributes = {
    # Mandated by Bazel, with values set according to the java rules
    # in https://github.com/bazelbuild/bazel/blob/0.22.0/src/main/java/com/google/devtools/build/lib/bazel/rules/java/BazelJavaTestRule.java#L69-L76
    "_jacocorunner": attr.label(
        default = Label("@bazel_tools//tools/jdk:JacocoCoverage"),
        cfg = "host",
    ),
    "_lcov_merger": attr.label(
        default = Label("@bazel_tools//tools/test/CoverageOutputGenerator/java/com/google/devtools/coverageoutputgenerator:Main"),
        cfg = "host",
    ),
}

def _extras_attributes(extras):
    return {
        "_phase_providers": attr.label_list(
            default = [pp for extra in extras for pp in extra["phase_providers"]],
            providers = [_ScalaRulePhase],
        ),
    }

def _scala_library_implementation(ctx):
    return _run_phases(ctx, [
        ("resources", _phase_resources),
        ("classpaths", _phase_classpaths),
        ("javainfo", _phase_javainfo),
        ("compile", _phase_noop),
        ("singlejar", _phase_singlejar),
        ("coverage", _phase_coverage_jacoco),
        ("ijinfo", _phase_ijinfo),
        ("library_defaultinfo", _phase_library_defaultinfo),
        ("coda", _phase_coda),
    ]).coda

def _scala_binary_implementation(ctx):
    return _run_phases(ctx, [
        ("resources", _phase_resources),
        ("classpaths", _phase_classpaths),
        ("javainfo", _phase_javainfo),
        ("compile", _phase_noop),
        ("singlejar", _phase_singlejar),
        ("coverage", _phase_coverage_jacoco),
        ("ijinfo", _phase_ijinfo),
        ("binary_deployjar", _phase_binary_deployjar),
        ("binary_launcher", _phase_binary_launcher),
        ("coda", _phase_coda),
    ]).coda

def _scala_test_implementation(ctx):
    return _run_phases(ctx, [
        ("resources", _phase_resources),
        ("classpaths", _phase_classpaths),
        ("javainfo", _phase_javainfo),
        ("compile", _phase_noop),
        ("singlejar", _phase_singlejar),
        ("coverage", _phase_coverage_jacoco),
        ("ijinfo", _phase_ijinfo),
        ("test_launcher", _phase_test_launcher),
        ("coda", _phase_coda),
    ]).coda

def make_scala_library(*extras):
    return rule(
        attrs = _dicts.add(
            _compile_attributes,
            _compile_private_attributes,
            _library_attributes,
            _extras_attributes(extras),
            *[extra["attrs"] for extra in extras]
        ),
        doc = "Compiles a Scala JVM library.",
        outputs = _dicts.add(
            {
                "jar": "%{name}.jar",
            },
            *[extra["outputs"] for extra in extras]
        ),
        implementation = _scala_library_implementation,
    )

scala_library = make_scala_library()

def make_scala_binary(*extras):
    return rule(
        attrs = _dicts.add(
            _compile_attributes,
            _compile_private_attributes,
            _runtime_attributes,
            _runtime_private_attributes,
            {
                "main_class": attr.string(
                    doc = "The main class. If not provided, it will be inferred by its type signature.",
                ),
            },
            _extras_attributes(extras),
            *[extra["attrs"] for extra in extras]
        ),
        doc = """
Compiles and links a Scala JVM executable.

Produces the following implicit outputs:

  - `<name>_deploy.jar`: a single jar that contains all the necessary information to run the program
  - `<name>.jar`: a jar file that contains the class files produced from the sources
  - `<name>-bin`: the script that's used to run the program in conjunction with the generated runfiles

To run the program: `bazel run <target>`
""",
        executable = True,
        outputs = _dicts.add(
            {
                "bin": "%{name}-bin",
                "jar": "%{name}.jar",
                "deploy_jar": "%{name}_deploy.jar",
            },
            *[extra["outputs"] for extra in extras]
        ),
        implementation = _scala_binary_implementation,
    )

scala_binary = make_scala_binary()

def make_scala_test(*extras):
    return rule(
        attrs = _dicts.add(
            _compile_attributes,
            _compile_private_attributes,
            _runtime_attributes,
            _runtime_private_attributes,
            _testing_private_attributes,
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
                "runner": attr.label(default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/zinc/test"),
                "subprocess_runner": attr.label(default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/common/sbt-testing:subprocess"),
            },
            _extras_attributes(extras),
            *[extra["attrs"] for extra in extras]
        ),
        doc = """
Compiles and links a collection of Scala tests.

To buid and run all tests: `bazel test <target>`

To build and run a specific test: `bazel test <target> --test_filter=<filter_expression>`
<br>(Note: the syntax of the `<filter_expression>` varies by test framework, and not all test frameworks support the `test_filter` option at this time.)

[More Info](/docs/scala.md#tests)
""",
        executable = True,
        outputs = _dicts.add(
            {
                "bin": "%{name}-bin",
                "jar": "%{name}.jar",
            },
            *[extra["outputs"] for extra in extras]
        ),
        test = True,
        implementation = _scala_test_implementation,
    )

scala_test = make_scala_test()

# scala_repl

_scala_repl_private_attributes = _dicts.add(
    _runtime_private_attributes,
    {
        "_runner": attr.label(
            cfg = "host",
            executable = True,
            default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/zinc/repl",
        ),
    },
)

scala_repl = rule(
    attrs = _dicts.add(
        _scala_repl_private_attributes,
        {
            "data": attr.label_list(
                doc = "The additional runtime files needed by this REPL.",
                allow_files = True,
            ),
            "deps": attr.label_list(providers = [JavaInfo]),
            "jvm_flags": attr.string_list(
                doc = "The JVM runtime flags.",
            ),
            "scala": attr.label(
                default = "//external:default_scala",
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
    doc = """
Launches a REPL with all given dependencies available.

To run: `bazel run <target>`
""",
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

configure_bootstrap_scala = rule(
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
        "global_scalacopts": attr.string_list(
            doc = "Scalac options that will always be enabled.",
        ),
    },
    implementation = _configure_bootstrap_scala_implementation,
)

_configure_zinc_scala = rule(
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
        "global_scalacopts": attr.string_list(
            doc = "Scalac options that will always be enabled.",
        ),
        "log_level": attr.string(
            doc = "Compiler log level",
            default = "warn",
        ),
        "deps_direct": attr.string(default = "error"),
        "deps_used": attr.string(default = "error"),
        "_compile_worker": attr.label(
            default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/zinc/compile",
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "_deps_worker": attr.label(
            default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/deps",
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "_code_coverage_instrumentation_worker": attr.label(
            default = "@rules_scala_annex//src/main/scala/higherkindness/rules_scala/workers/jacoco/instrumenter",
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
    },
    implementation = _configure_zinc_scala_implementation,
)

def configure_zinc_scala(**kwargs):
    _configure_zinc_scala(
        deps_direct = select({
            "@rules_scala_annex//src/main/scala:deps_direct_off": "off",
            "//conditions:default": "error",
        }),
        deps_used = select({
            "@rules_scala_annex//src/main/scala:deps_used_off": "off",
            "//conditions:default": "error",
        }),
        **kwargs
    )
