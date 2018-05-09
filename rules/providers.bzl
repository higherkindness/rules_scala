ScalaConfiguration = provider(
    doc = "Provides access to the Scala compiler jars",
    fields = {
        "version": "the Scala full version",
        "compiler_classpath": "the compiler classpath",
        "runtime_classpath": "the minimal runtime classpath",
    },
)

def _declare_scala_configuration_implementation(ctx):
    return [
        java_common.merge(_collect(JavaInfo, ctx.attr.compiler_classpath)),
        ScalaConfiguration(
            version = ctx.attr.version,
            compiler_classpath = ctx.files.compiler_classpath,
            runtime_classpath = ctx.attr.runtime_classpath,
        ),
    ]

declare_scala_configuration = rule(
    implementation = _declare_scala_configuration_implementation,
    attrs = {
        "version": attr.string(
            mandatory = True,
        ),
        "compiler_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
        "runtime_classpath": attr.label_list(
            mandatory = True,
            providers = [JavaInfo],
        ),
    },
)

ScalaInfo = provider(
    doc = "Provider for cross versioned scala rule outputs",
    fields = {
        "macro": "whether the jar contains macros",
        "scala_configuration": "the scala configuration associated with this output",
    },
)

ZincConfiguration = provider(
    doc = "Provides additional items needed by Zinc",
    fields = {
        "compiler_bridge": "the compiled Zinc compiler bridge",
    },
)

def _declare_zinc_configuration_implementation(ctx):
    return [ZincConfiguration(
        compiler_bridge = ctx.files.compiler_bridge,
    )]

declare_zinc_configuration = rule(
    implementation = _declare_zinc_configuration_implementation,
    attrs = {
        "compiler_bridge": attr.label(
            allow_single_file = True,
            mandatory = True,
        ),
    },
)

ZincInfo = provider(
    doc = "Provides additional outputs from Zinc",
    fields = {
        "apis": "API file",
        "deps": "Depset",
        "deps_files": "Depset of all files",
        "label": "Label",
        "relations": "Relations file",
    },
)

def _collect(index, entries):
    return [
        entry[index]
        for entry in entries
        if index in entry
    ]

def _join_configurations_implementation(ctx):
    return (
        _collect(ScalaConfiguration, ctx.attr.configurations) +
        _collect(ZincConfiguration, ctx.attr.configurations)
    )

join_configurations = rule(
    implementation = _join_configurations_implementation,
    attrs = {
        "configurations": attr.label_list(
            mandatory = True,
            providers = [[ScalaConfiguration], [ZincConfiguration]],
        ),
    },
)

# TODO: move these to another file?
# TODO: implement these with an aspect?

IntellijInfo = provider(
    doc = "Provider for IntelliJ",
    fields = {
        "outputs": "java_output_jars",
        "transitive_exports": "labels of transitive dependencies",
    },
)

LabeledJars = provider(
    doc = "Exported jars and their labels",
    fields = {
        "values": "Preorder depset of label and jars",
    },
)
