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
    "//rules/private:phases.bzl",
    _adjust_phases = "adjust_phases",
    _phase_binary_deployjar = "phase_binary_deployjar",
    _phase_binary_launcher = "phase_binary_launcher",
    _phase_classpaths = "phase_classpaths",
    _phase_coda = "phase_coda",
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
    "_java": attr.label(
        default = Label("@bazel_tools//tools/jdk:java"),
        executable = True,
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
        default = "//external:default_scala",
        doc = "The `ScalaConfiguration`.",
        providers = [
            _ScalaConfiguration,
        ],
    ),
    "scalacopts": attr.string_list(
        doc = "The Scalac options.",
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
    "_java": attr.label(
        default = Label("@bazel_tools//tools/jdk:java"),
        executable = True,
        cfg = "host",
    ),
    "_java_stub_template": attr.label(
        default = Label("@anx_java_stub_template//file"),
        allow_single_file = True,
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
        ("ijinfo", _phase_ijinfo),
        ("test_launcher", _phase_test_launcher),
        ("coda", _phase_coda),
    ]).coda

def make_scala_library(*extras):
    return rule(
        attrs = _dicts.add(
            _compile_attributes,
            _compile_private_attributes,
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
        doc = "Compiles and links a Scala JVM executable.",
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
                cfg = "data",
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
    },
    implementation = _configure_bootstrap_scala_implementation,
)

configure_zinc_scala = rule(
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
    },
    implementation = _configure_zinc_scala_implementation,
)
