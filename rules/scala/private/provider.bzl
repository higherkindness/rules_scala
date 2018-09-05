load(
    "@rules_scala_annex//rules:providers.bzl",
    new_ScalaConfiguration = "ScalaConfiguration",
    new_ZincConfiguration = "ZincConfiguration",
)

def configure_basic_scala_implementation(ctx):
    return [
        new_ScalaConfiguration(
            version = ctx.attr.version,
            compiler_classpath = ctx.files.compiler_classpath,
            runtime_classpath = ctx.attr.runtime_classpath,
        ),
    ]

def configure_scala_implementation(ctx):
    return ([
        new_ZincConfiguration(
            compiler_bridge = ctx.file.compiler_bridge,
        ),
    ] + configure_basic_scala_implementation(ctx))
