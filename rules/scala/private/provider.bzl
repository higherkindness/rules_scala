load(
    "@rules_scala_annex//rules:providers.bzl",
    new_ScalaConfiguration = "ScalaConfiguration",
    new_ZincConfiguration = "ZincConfiguration",
)

def configure_basic_scala_implementation(ctx):
    return [
        new_ScalaConfiguration(
            compiler_classpath = ctx.files.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
            runtime_classpath = ctx.attr.runtime_classpath,
            version = ctx.attr.version,
        ),
    ]

annex_configure_basic_scala_implementation = configure_basic_scala_implementation

def configure_scala_implementation(ctx):
    return ([
        new_ZincConfiguration(
            compiler_bridge = ctx.file.compiler_bridge,
        ),
    ] + configure_basic_scala_implementation(ctx))

annex_configure_scala_implementation = configure_scala_implementation
