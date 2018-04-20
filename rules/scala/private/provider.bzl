load("@rules_scala_annex//rules/scala:provider.bzl", "BasicScalaConfiguration", "ScalaConfiguration")

def annex_configure_basic_scala_implementation(ctx):
    return [BasicScalaConfiguration(
        version = ctx.attr.version,
        compiler_classpath = ctx.files.compiler_classpath,
        runtime_classpath = ctx.files.runtime_classpath,
    )]

def annex_configure_scala_implementation(ctx):
    return [ScalaConfiguration(
        version = ctx.attr.version,
        compiler_bridge = ctx.file.compiler_bridge,
        compiler_classpath = ctx.files.compiler_classpath,
        runtime_classpath = ctx.files.runtime_classpath,
    )]
