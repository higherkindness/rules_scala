load(
    "@rules_scala_annex//rules:internal/build_internal.bzl",
    "annex_scala_runner_toolchain_implementation",
    "annex_configure_scala_implementation",
    "annex_configure_scala_private_attributes",
    "annex_scala_library_implementation",
    "annex_scala_library_private_attributes",
    "annex_scala_binary_implementation",
    "annex_scala_binary_private_attributes",
    "annex_scala_test_implementation",
    "annex_scala_test_private_attributes",
    "annex_scala_format_test_implementation",
)
load(
    "@rules_scala_annex//rules:providers.bzl",
    "ScalaConfiguration",
)

"""
Configures which Scala runner to use
"""
annex_scala_runner_toolchain = rule(
    annex_scala_runner_toolchain_implementation,
    attrs = {
        "runner": attr.label(
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
    },
)

###

"""
Configures a Scala provider for use by library, binary, and test rules.

Args:

  version:
    The full Scala version string, such as "2.12.5"

  binary_version:
    The binary Scala version string, such as "2.12"

  runtime_classpath:
    The full Scala runtime classpath for use in library, binary, and test rules;
    i.e. scala-library + scala-reflect + ...

  compiler_classpath:
    The full Scala compiler classpath required to invoke the Scala compiler;
    i.e.. scala-compiler + scala-library +  scala-reflect + ...

  compiler_bridge:
    The Zinc compiler bridge with attached sources.

  compiler_bridge_classpath:
    The Zinc classpath entries required to compile the compiler_bridge sources
    against Scala's compiler_classpath.

"""
annex_configure_scala = rule(
    implementation = annex_configure_scala_implementation,
    attrs = annex_configure_scala_private_attributes + {
        "version": attr.string(mandatory = True),
        "binary_version": attr.string(mandatory = True),
        "runtime_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "compiler_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
        "compiler_bridge": attr.label(mandatory = True, providers = [JavaInfo]),
        "compiler_bridge_classpath": attr.label_list(mandatory = True, providers = [JavaInfo]),
    },
)

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
    implementation = annex_scala_library_implementation,
    attrs = annex_scala_library_private_attributes + {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "exports": attr.label_list(),
        "scala": attr.label_list(
            mandatory = True,
            providers = [ScalaConfiguration],
        ),
        "plugins": attr.label_list(),
        "use_ijar": attr.bool(default = True),
    },
    toolchains = ["@rules_scala_annex//rules:runner_toolchain_type"],
    outputs = {},
)

annex_scala_binary = rule(
    implementation = annex_scala_binary_implementation,
    attrs = annex_scala_binary_private_attributes + {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "exports": attr.label_list(),
        "main_class": attr.string(),
        "scala": attr.label_list(
            mandatory = True,
            providers = [ScalaConfiguration],
        ),
        "plugins": attr.label_list(),
        "use_ijar": attr.bool(default = True),
    },
    toolchains = ["@rules_scala_annex//rules:runner_toolchain_type"],
    executable = True,
    outputs = {},
)

annex_scala_test = rule(
    implementation = annex_scala_test_implementation,
    attrs = annex_scala_test_private_attributes + {
        "srcs": attr.label_list(allow_files = [".scala", ".java"]),
        "deps": attr.label_list(),
        "exports": attr.label_list(),
        "scala": attr.label_list(
            mandatory = True,
            providers = [ScalaConfiguration],
        ),
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
        "runner": attr.label(default = Label("@rules_scala_annex//runners/test:runner")),
    },
    toolchains = ["@rules_scala_annex//rules:runner_toolchain_type"],
    test = True,
    executable = True,
    outputs = {},
)

annex_scala_format_test = rule(
    implementation = annex_scala_format_test_implementation,
    attrs = {
        "_format": attr.label(
            cfg = "host",
            default = "@rules_scala_annex//runners/scalafmt:runner",
            executable = True,
        ),
        "_runner": attr.label(
            allow_single_file = True,
            default = "@rules_scala_annex//rules/internal:format",
        ),
        "config": attr.label(allow_single_file = [".conf"], default = "@scalafmt_default//:config"),
        "srcs": attr.label_list(allow_files = [".scala"]),
    },
    test = True,
    outputs = {
        "runner": "%{name}-format",
    },
)
