"""
Rules for invoking scalac directly.

These are some of the lower level rules. They are needed
to bootstrap some of the higher level rules used in the annex.

You probably don't want to use these directly!

"""

load("@rules_scala_annex//rules/scala:provider.bzl", "BasicScalaConfiguration")
load(
    "//rules/scalac:private.bzl",
    _scalac_library_implementation = "scalac_library_implementation",
    _scalac_library_private_attributes = "scalac_library_private_attributes",
    _scalac_binary_implementation = "scalac_binary_implementation",
    _scalac_binary_private_attributes = "scalac_binary_private_attributes",
)

scalac_library = rule(
    implementation = _scalac_library_implementation,
    attrs = _scalac_library_private_attributes + {
        "srcs": attr.label_list(
            allow_files = [".scala", ".java", ".srcjar"]
        ),
        "deps": attr.label_list(),
        "scala": attr.label(
            mandatory = True,
            providers = [BasicScalaConfiguration],
        ),
    },
    fragments = ["java"],
)

scalac_binary = rule(
    implementation = _scalac_binary_implementation,
    attrs = _scalac_binary_private_attributes + {
        "srcs": attr.label_list(
            allow_files = [".scala", ".java", ".srcjar"]
        ),
        "deps": attr.label_list(),
        "main_class": attr.string(mandatory = True),
        "scala": attr.label(
            mandatory = True,
            providers = [BasicScalaConfiguration],
        ),
    },
    fragments = ["java"],
    executable = True,
)