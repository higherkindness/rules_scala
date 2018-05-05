load(
    "//rules/scala_proto:private/core.bzl",
    _scala_proto_library_implementation = "scala_proto_library_implementation",
    _scala_proto_library_private_attributes = "scala_proto_library_private_attributes",
)

scala_proto_library = rule(
    implementation = _scala_proto_library_implementation,
    attrs = dict({
        "deps": attr.label_list(),
    }, **_scala_proto_library_private_attributes),
    toolchains = [
        "@rules_scala_annex//rules/scala_proto:compiler_toolchain_type",
    ],
    outputs = {
        "srcjar": "%{name}.srcjar",
    },
)

def _scala_proto_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        compiler = ctx.attr.compiler,
        compiler_supports_workers = ctx.attr.compiler_supports_workers,
    )]

scala_proto_toolchain = rule(
    implementation = _scala_proto_toolchain_implementation,
    attrs = {
        "compiler": attr.label(
            allow_files = True,
            executable = True,
            cfg = "host",
        ),
        "compiler_supports_workers": attr.bool(default = False),
    },
)
