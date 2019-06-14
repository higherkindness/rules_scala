load(
    "@rules_scala_annex//rules:providers.bzl",
    _ScalaConfiguration = "ScalaConfiguration",
    _ZincConfiguration = "ZincConfiguration",
)
load(
    "//rules/common:private/utils.bzl",
    _collect = "collect",
)
load(
    "//rules/common:private/utils.bzl",
    _resolve_execution_reqs = "resolve_execution_reqs",
)

scaladoc_private_attributes = {
    "_runner": attr.label(
        cfg = "host",
        executable = True,
        default = "//src/main/scala/higherkindness/rules_scala/workers/zinc/doc",
    ),
}

def scaladoc_implementation(ctx):
    scala_configuration = ctx.attr.scala[_ScalaConfiguration]
    zinc_configuration = ctx.attr.scala[_ZincConfiguration]

    scompiler_classpath = java_common.merge(
        _collect(JavaInfo, scala_configuration.compiler_classpath),
    )

    html = ctx.actions.declare_directory("html")
    tmp = ctx.actions.declare_directory("tmp")

    classpath = depset(transitive = [dep[JavaInfo].transitive_deps for dep in ctx.attr.deps])
    compiler_classpath = depset(
        transitive =
            [scompiler_classpath.transitive_runtime_deps] +
            [dep[JavaInfo].transitive_runtime_deps for dep in ctx.attr.compiler_deps],
    )

    srcs = [file for file in ctx.files.srcs if file.extension.lower() in ["java", "scala"]]
    src_jars = [file for file in ctx.files.srcs if file.extension.lower() == "srcjar"]

    scalacopts = ["-doc-title", ctx.attr.title or ctx.label] + ctx.attr.scalacopts

    args = ctx.actions.args()
    args.add("--compiler_bridge", zinc_configuration.compiler_bridge)
    args.add_all("--compiler_classpath", compiler_classpath)
    args.add_all("--classpath", classpath)
    args.add_all(scalacopts, format_each = "--option=%s")
    args.add("--output_html", html.path)
    args.add_all("--source_jars", src_jars)
    args.add("--tmp", tmp.path)
    args.add_all("--", srcs)
    args.set_param_file_format("multiline")
    args.use_param_file("@%s", use_always = True)

    runner_inputs, _, input_manifests = ctx.resolve_command(tools = [ctx.attr._runner])

    ctx.actions.run(
        arguments = [args],
        executable = ctx.attr._runner.files_to_run.executable,
        execution_requirements = _resolve_execution_reqs(ctx, {"supports-workers": "1"}),
        input_manifests = input_manifests,
        inputs = depset(
            src_jars + srcs + [zinc_configuration.compiler_bridge],
            transitive = [classpath, compiler_classpath],
        ),
        mnemonic = "ScalaDoc",
        outputs = [html, tmp],
    )

    return [
        DefaultInfo(
            files = depset([html]),
        ),
    ]
