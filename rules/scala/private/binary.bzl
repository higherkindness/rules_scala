load("//rules/common:private/utils.bzl", "write_launcher")
load(":private/library.bzl", "runner_common", "runner_common_attributes")

annex_scala_binary_private_attributes = runner_common_attributes + {
    "_java": attr.label(
        default = Label("@bazel_tools//tools/jdk:java"),
        executable = True,
        cfg = "host",
    ),
    "_java_stub_template": attr.label(
        default = Label("@anx_java_stub_template//file"),
    ),
}

def annex_scala_binary_implementation(ctx):
    res = runner_common(ctx)

    # this is all super sketchy...
    # for the time being

    java_info = res.java_info
    mains_file = res.mains_files.to_list()[0]

    files = write_launcher(
        ctx,
        ctx.outputs.bin,
        java_info.transitive_runtime_deps,
        main_class = "$(head -1 $JAVA_RUNFILES/{}/{})".format(ctx.workspace_name, mains_file.short_path),
        jvm_flags = [],
    )

    for entry in ctx.attr.data:
        print(dir(entry))
        print(entry.files)
    data_files = [entry.files for entry in ctx.attr.data]

    return struct(
        providers = [
            res.java_info,
            res.scala_info,
            res.zinc_info,
            res.intellij_info,
            DefaultInfo(
                executable = ctx.outputs.bin,
                files = depset(files, transitive = [res.files] + data_files),
                runfiles = ctx.runfiles(
                    files = files + [mains_file],
                    transitive_files = depset(
                        order = "default",
                        direct = [ctx.executable._java],
                        transitive = [java_info.transitive_runtime_deps] + data_files,
                    ),
                    collect_default = True,
                ),
            ),
            OutputGroupInfo(
                analysis = depset([res.analysis, res.apis]),
            ),
        ],
        java = res.intellij_info,
    )
