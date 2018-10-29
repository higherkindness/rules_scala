scala_format_private_attributes = {
    "_format": attr.label(
        cfg = "host",
        default = "@rules_scala_annex//rules/scalafmt",
        executable = True,
    ),
    "_runner": attr.label(
        allow_single_file = True,
        default = "@rules_scala_annex//rules/scalafmt:runner",
    ),
}

def scala_format_test_implementation(ctx):
    files = []
    runner_inputs, _, runner_manifests = ctx.resolve_command(tools = [ctx.attr._format])
    toolchain = ctx.toolchains["@rules_scala_annex//rules/scala:runner_toolchain_type"]
    manifest_content = []
    for src in ctx.files.srcs:
        file = ctx.actions.declare_file(src.short_path)
        files.append(file)
        args = ctx.actions.args()
        args.add("--config")
        args.add(ctx.file.config.path)
        args.add(src.path)
        args.add(file.path)
        args.set_param_file_format("multiline")
        args.use_param_file("@%s", use_always = True)
        ctx.actions.run(
            arguments = ["--jvm_flag=-Dfile.encoding=" + toolchain.encoding, args],
            executable = ctx.executable._format,
            outputs = [file],
            input_manifests = runner_manifests,
            inputs = runner_inputs + [ctx.file.config, src],
            execution_requirements = {"supports-workers": "1"},
            mnemonic = "ScalaFmt",
        )
        manifest_content.append("{} {}".format(src.short_path, file.short_path))

    manifest = ctx.actions.declare_file("{}/manifest.txt".format(ctx.label.name))
    ctx.actions.write(manifest, "\n".join(manifest_content) + "\n")

    ctx.actions.expand_template(
        template = ctx.file._runner,
        output = ctx.outputs.runner,
        substitutions = {
            "%workspace%": ctx.workspace_name,
            "%manifest%": manifest.short_path,
        },
        is_executable = True,
    )

    return DefaultInfo(
        executable = ctx.outputs.runner,
        files = depset([ctx.outputs.runner, manifest] + files),
        runfiles = ctx.runfiles(files = [manifest] + files + ctx.files.srcs),
    )
