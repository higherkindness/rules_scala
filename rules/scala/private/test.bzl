load("//rules/common:private/utils.bzl", "write_launcher")
load(":private/library.bzl", "runner_common")
load(":private/binary.bzl", "annex_scala_binary_private_attributes")

annex_scala_test_private_attributes = annex_scala_binary_private_attributes

def annex_scala_test_implementation(ctx):
    res = runner_common(ctx)

    files = ctx.files._java + [res.apis]

    test_jars = res.java_info.transitive_runtime_deps
    runner_jars = ctx.attr.runner[JavaInfo].transitive_runtime_deps

    args = ctx.actions.args()
    if hasattr(args, "add_all"):  # Bazel 0.13.0+
        args.add("--apis", res.apis.short_path)
        args.add("--frameworks", ctx.attr.frameworks)
        args.add("--")
        args.add_all(res.java_info.transitive_runtime_jars, map_each = _short_path)
    else:
        args.add("--apis")
        args.add(res.apis.short_path)
        args.add("--frameworks")
        args.add(ctx.attr.frameworks)
        args.add("--")
        args.add(res.java_info.transitive_runtime_jars, map_fn = _short_paths)
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file("{}/test.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    files.append(args_file)

    files += write_launcher(
        ctx,
        ctx.outputs.bin,
        runner_jars,
        "annex.TestRunner",
        [
            "-Dbazel.runPath=$RUNPATH",
            "-DscalaAnnex.test.args=${{RUNPATH}}{}".format(args_file.short_path),
        ],
    )

    test_info = DefaultInfo(
        executable = ctx.outputs.bin,
        files = res.files,
        runfiles = ctx.runfiles(collect_default = True, collect_data = True, files = files, transitive_files = depset([], transitive = [runner_jars, test_jars])),
    )
    return struct(
        providers = [
            res.java_info,
            res.scala_info,
            res.intellij_info,
            test_info,
            OutputGroupInfo(
                analysis = depset([res.analysis, res.apis]),
            ),
        ],
        java = res.intellij_info,
    )

def _short_path(file):
    return file.short_path

def _short_paths(files):
    return [file.short_path for file in files]
