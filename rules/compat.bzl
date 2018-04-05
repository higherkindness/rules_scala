"""
Provides compatibility with vanilla rules_scala rules

The aim is to implement compatibility strictly with macros. `bazel query`
can be used to expand macro usage and provide a seamless transition to
newer rules.
"""

load(":build.bzl",
     "annex_scala_library")

# use the same fixed version as rules_scala
_scala = [ "@scalas//:scala_2_11_11" ]


def scala_library(
        # bazel rule attributes
        name,
        tags                  = [],
        # rules_scala common attributes
        srcs                  = [],
        deps                  = [],
        plugins               = [],
        runtime_deps          = [],
        data                  = [],
        resources             = [],
        resource_strip_prefix = None,
        resource_jars         = [],
        scalacopts            = [],
        javacopts             = [],
        jvm_flags             = [],
        scalac_jvm_flags      = [],
        javac_jvm_flags       = [],
        print_compile_time    = False,
        # library only attributes
        main_class            = None,
        exports               = [],
):

    if plugins               != []    : print("%s: plugins unsupported")
    if runtime_deps          != []    : print("%s: runtime_deps unsupported")
    if data                  != []    : print("%s: data unsupported")
    if resources             != []    : print("%s: resources unsupported")
    if resource_strip_prefix != None  : print("%s: resource_strip_prefix unsupported")
    if resource_jars         != []    : print("%s: resource_jars unsupported")
    if scalacopts            != []    : print("%s: scalacopts unsupported")
    if javacopts             != []    : print("%s: javacopts unsupported")
    if jvm_flags             != []    : print("%s: jvm_flags unsupported")
    if scalac_jvm_flags      != []    : print("%s: scalac_jvm_flags unsupported")
    if javac_jvm_flags       != []    : print("%s: javac_jvm_flags unsupported")
    if print_compile_time    != False : print("%s: print_compile_time unsupported")
    if main_class            != None  : print("%s: main_class unsupported")

    annex_scala_library(
        name = name,
        srcs = srcs,
        deps = deps,
        exports = exports,
        scala = _scala,
        tags = tags,
    )
