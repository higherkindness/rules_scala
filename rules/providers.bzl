ScalaConfiguration = provider(
    doc = "Provides access to the Scala compiler jars",
    fields = {
        "version": "the Scala full version",
        "compiler_classpath": "the compiler classpath",
        "runtime_classpath": "the minimal runtime classpath",
    },
)

def _declare_scala_configuration_implementation(ctx):
    return [ScalaConfiguration(
        version = ctx.attr.version,
        compiler_classpath = ctx.files.compiler_classpath,
        runtime_classpath = ctx.attr.runtime_classpath,
    )]

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
        "analysis": "Zinc analysis file in binary form",
    },
)

def _zinc_info_implementation(ctx):
    input = ctx.attr.dep[ZincInfo].analysis
    output = ctx.outputs.analysis
    ctx.actions.run_shell(
        inputs = [input],
        outputs = [output],
        command = "cp %s %s" % (input.path, output.path),
    )

zinc_info = rule(
    implementation = _zinc_info_implementation,
    attrs = {
        "dep": attr.label(
            mandatory = True,
            providers = [ZincInfo],
        ),
    },
    outputs = {
        "analysis": "%{name}.gz",
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
