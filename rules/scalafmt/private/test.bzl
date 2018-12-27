"""
    "_fmt": attr.label(
        cfg = "host",
        default = "@rules_scala_annex//rules/scalafmt",
        executable = True,
    ),
    "_runner": attr.label(
        allow_single_file = True,
        default = "@rules_scala_annex//rules/scalafmt:runner",
    ),
"""

scala_format_attributes = {
    "config": attr.label(
        allow_single_file = [".conf"],
        default = "@scalafmt_default//:config",
        doc = "The Scalafmt configuration file.",
    ),
}

"""
    "_testrunner": attr.label(
        allow_single_file = True,
        default = "@rules_scala_annex//rules/scalafmt:testrunner",
    ),
"""

scala_non_default_format_attributes = {
    "format": attr.bool(
        default = False,
    ),
}

def build_format(ctx):
    files = []
    runner_inputs, _, runner_manifests = ctx.resolve_command(tools = [ctx.attr._fmt])
    manifest_content = []
    for src in ctx.files.srcs:
        if src.path.endswith(".scala") and src.is_source:
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
                arguments = [args],  #["--jvm_flag=-Dfile.encoding=" + toolchain.encoding, args],
                executable = ctx.executable._fmt,
                outputs = [file],
                input_manifests = runner_manifests,
                inputs = runner_inputs + [ctx.file.config, src],
                execution_requirements = {"supports-workers": "1"},
                mnemonic = "ScalaFmt",
            )
            manifest_content.append("{} {}".format(src.short_path, file.short_path))

    manifest = ctx.actions.declare_file("{}/manifest.txt".format(ctx.label.name))
    ctx.actions.write(manifest, "\n".join(manifest_content) + "\n")

    return manifest, files

def format_runner(ctx, manifest, files):
    ctx.actions.run_shell(
        inputs = [ctx.file._runner, manifest] + files,
        outputs = [ctx.outputs.runner],
        command = "cat $1 | sed -e s#%workspace%#$2# -e s#%manifest%#$3# > $4",
        arguments = [ctx.file._runner.path, ctx.workspace_name, manifest.short_path, ctx.outputs.runner.path],
    )

def format_tester(ctx, manifest, files):
    ctx.actions.run_shell(
        inputs = [ctx.file._testrunner, manifest] + files,
        outputs = [ctx.outputs.testrunner],
        command = "cat $1 | sed -e s#%workspace%#$2# -e s#%manifest%#$3# > $4",
        arguments = [ctx.file._testrunner.path, ctx.workspace_name, manifest.short_path, ctx.outputs.testrunner.path],
    )

def scala_format_test_implementation(ctx):
    """
    manifest, files = build_format(ctx)
    format_runner(ctx, manifest, files)

    return DefaultInfo(
        executable = ctx.outputs.runner,
        files = depset([ctx.outputs.runner, manifest] + files),
        runfiles = ctx.runfiles(files = [manifest] + files + ctx.files.srcs),
    )
    """

    # TODO: remove temp hack
    ctx.actions.run_shell(
        inputs = [],
        outputs = [ctx.outputs.runner],
        command = "touch $1",
        arguments = [ctx.outputs.runner.path],
    )

    return DefaultInfo(
        executable = ctx.outputs.runner,
        files = depset([ctx.outputs.runner]),
        runfiles = ctx.runfiles(files = []),
    )
