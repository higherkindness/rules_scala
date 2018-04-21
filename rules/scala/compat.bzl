"""
Provides compatibility with vanilla rules_scala rules

The aim is to implement compatibility strictly with macros. `bazel query`
can be used to expand macro usage and provide a seamless transition to
newer rules.
"""

load("//rules:scala.bzl", "annex_scala_library")

# use the same fixed version as rules_scala
_scala = "@scala_2_11"

def scala_library(
        # bazel rule attributes
        name,
        tags = [],
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
    if runtime_deps != []:
        fail("%s: runtime_deps unsupported" % name)
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
        fail("%s: print_compile_time unsupported" % name)
    if main_class != None:
        fail("%s: main_class unsupported" % name)

    annex_scala_library(
        name = name,
        srcs = srcs,
        deps = deps,
        exports = exports,
        scala = _scala,
        tags = tags,
        use_ijar = _use_ijar,
    )

def scala_macro_library(
        # bazel rule attributes
        name,
        tags = [],
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
