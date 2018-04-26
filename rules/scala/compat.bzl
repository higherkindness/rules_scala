"""
Provides compatibility with vanilla rules_scala rules

The aim is to implement compatibility strictly with macros. `bazel query`
can be used to expand macro usage and provide a seamless transition to
newer rules.
"""

load(
    "//rules:scala.bzl",
    "annex_scala_library",
    "annex_scala_binary",
    "annex_scala_test",
)
load(
    "//rules:common/private/utils.bzl",
    "safe_name",
)

# use the same fixed version as rules_scala
_scala = "@scala_2_11"
_scalatest_deps = [
    "//external:scala_annex_dependency/scalatest/scalatest_2_11",
]

def scala_library(
        # bazel rule attributes
        name,
        tags = [],
        visibility = None,
        # rules_scala common attributes
        srcs = [],
        deps = [],
        plugins = [],
        runtime_deps = [],
        data = [],
        resources = [],
        resource_strip_prefix = None,
        resource_jars = [],
        scalacopts = [],
        javacopts = [],
        jvm_flags = [],
        scalac_jvm_flags = [],
        javac_jvm_flags = [],
        print_compile_time = False,
        # library only attributes
        main_class = None,
        exports = [],
        # compat layer internals
        _use_ijar = True):
    if plugins != []:
        fail("%s: plugins unsupported" % name)
    if data != []:
        fail("%s: data unsupported" % name)
    if resources != []:
        fail("%s: resources unsupported" % name)
    if resource_strip_prefix != None:
        fail("%s: resource_strip_prefix unsupported" % name)
    if resource_jars != []:
        fail("%s: resource_jars unsupported" % name)
    if javacopts != []:
        fail("%s: javacopts unsupported" % name)
    if jvm_flags != []:
        fail("%s: jvm_flags unsupported" % name)
    if scalac_jvm_flags != []:
        fail("%s: scalac_jvm_flags unsupported" % name)
    if javac_jvm_flags != []:
        fail("%s: javac_jvm_flags unsupported" % name)
    if print_compile_time != False:
        print("%s: print_compile_time unsupported" % name)
    if main_class != None:
        fail("%s: main_class unsupported" % name)

    annex_scala_library(
        name = name,
        srcs = srcs,
        deps = deps,
        macro = not _use_ijar,
        runtime_deps = runtime_deps,
        exports = exports,
        scala = _scala,
        scalacopts = scalacopts,
        tags = tags,
        visibility = visibility,
    )

def scala_macro_library(
        # bazel rule attributes
        name,
        tags = [],
        visibility = None,
        # rules_scala common attributes
        srcs = [],
        deps = [],
        plugins = [],
        runtime_deps = [],
        data = [],
        resources = [],
        resource_strip_prefix = None,
        resource_jars = [],
        scalacopts = [],
        javacopts = [],
        jvm_flags = [],
        scalac_jvm_flags = [],
        javac_jvm_flags = [],
        print_compile_time = False,
        # library only attributes
        main_class = None,
        exports = []):
    return scala_library(
        name,
        tags,
        visibility,
        srcs,
        deps,
        plugins,
        runtime_deps,
        data,
        resources,
        resource_strip_prefix,
        resource_jars,
        scalacopts,
        javacopts,
        jvm_flags,
        scalac_jvm_flags,
        javac_jvm_flags,
        print_compile_time,
        main_class,
        exports,
        False,  # _use_ijar
    )

def scala_binary(
        # bazel rule attributes
        name,
        tags = [],
        visibility = None,
        # rules_scala common attributes
        srcs = [],
        deps = [],
        plugins = [],
        runtime_deps = [],
        data = [],
        resources = [],
        resource_strip_prefix = None,
        resource_jars = [],
        scalacopts = [],
        javacopts = [],
        jvm_flags = [],
        scalac_jvm_flags = [],
        javac_jvm_flags = [],
        print_compile_time = False,
        # binary only attributes
        main_class = None,
        classpath_resources = [],
        # compat layer internals
        _use_ijar = True):
    if plugins != []:
        fail("%s: plugins unsupported" % name)
    if data != []:
        fail("%s: data unsupported" % name)
    if resources != []:
        fail("%s: resources unsupported" % name)
    if resource_strip_prefix != None:
        fail("%s: resource_strip_prefix unsupported" % name)
    if resource_jars != []:
        fail("%s: resource_jars unsupported" % name)
    if scalacopts != []:
        fail("%s: scalacopts unsupported" % name)
    if javacopts != []:
        fail("%s: javacopts unsupported" % name)
    if jvm_flags != []:
        fail("%s: jvm_flags unsupported" % name)
    if scalac_jvm_flags != []:
        fail("%s: scalac_jvm_flags unsupported" % name)
    if javac_jvm_flags != []:
        fail("%s: javac_jvm_flags unsupported" % name)
    if print_compile_time != False:
        print("%s: print_compile_time unsupported" % name)
    if classpath_resources != []:
        fail("%s: classpath_resources unsupported" % name)

    annex_scala_binary(
        name = name,
        main_class = main_class,
        srcs = srcs,
        deps = deps,
        macro = not _use_ijar,
        runtime_deps = runtime_deps,
        scala = _scala,
        tags = tags,
    )

def scala_test(
        # bazel rule attributes
        name,
        tags = [],
        visibility = None,
        # rules_scala common attributes
        srcs = [],
        deps = [],
        plugins = [],
        runtime_deps = [],
        data = [],
        resources = [],
        resource_strip_prefix = None,
        resource_jars = [],
        scalacopts = [],
        javacopts = [],
        jvm_flags = [],
        scalac_jvm_flags = [],
        javac_jvm_flags = [],
        print_compile_time = False,
        # test only attributes
        suites = [],
        colors = None,
        full_stacktraces = None,
        # compat layer internals
        _use_ijar = True,
        **kwargs):
    if plugins != []:
        fail("%s: plugins unsupported" % name)
    if data != []:
        fail("%s: data unsupported" % name)
    if resources != []:
        fail("%s: resources unsupported" % name)
    if resource_strip_prefix != None:
        fail("%s: resource_strip_prefix unsupported" % name)
    if resource_jars != []:
        fail("%s: resource_jars unsupported" % name)
    if scalacopts != []:
        fail("%s: scalacopts unsupported" % name)
    if javacopts != []:
        fail("%s: javacopts unsupported" % name)
    if jvm_flags != []:
        fail("%s: jvm_flags unsupported" % name)
    if scalac_jvm_flags != []:
        fail("%s: scalac_jvm_flags unsupported" % name)
    if javac_jvm_flags != []:
        fail("%s: javac_jvm_flags unsupported" % name)
    if print_compile_time != False:
        print("%s: print_compile_time unsupported" % name)
    if suites != []:
        fail("%s: suites unsupported" % name)
    if colors != None:
        print("%s: colors unsupported" % name)
    if full_stacktraces != None:
        print("%s: full_stacktraces unsupported" % name)

    annex_scala_test(
        name = name,
        srcs = srcs,
        deps = deps + _scalatest_deps,
        macro = not _use_ijar,
        runtime_deps = runtime_deps,
        scala = _scala,
        tags = tags,
        frameworks = ["org.scalatest.tools.Framework"],
    )

def scala_test_suite(
        name,
        srcs = [],
        deps = [],
        runtime_deps = [],
        data = [],
        resources = [],
        scalacopts = [],
        jvm_flags = [],
        visibility = None,
        size = None,
        colors = True,
        full_stacktraces = True):
    tests = []
    for src in srcs:
        test_name = "%s_test_suite_%s" % (name, safe_name(src))
        scala_test(
            name = test_name,
            srcs = [src],
            deps = deps,
            runtime_deps = runtime_deps,
            resources = resources,
            scalacopts = scalacopts,
            jvm_flags = jvm_flags,
            visibility = visibility,
            size = size,
            colors = colors,
            full_stacktraces = full_stacktraces,
        )
        tests.append(test_name)

    native.test_suite(
        name = name,
        tests = tests,
        visibility = visibility,
    )
