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

    launcher = ctx.new_file("%s.sh" % ctx.label.name)
    write_launcher(
        ctx,
        launcher,
        java_info.transitive_runtime_deps,
        main_class = "$(head -1 $JAVA_RUNFILES/{}/{})".format(ctx.workspace_name, mains_file.short_path),
        jvm_flags = [],
    )

    return [
        res.java_info,
        res.scala_info,
        DefaultInfo(
            executable = launcher,
            files = res.files,
            runfiles = ctx.runfiles(
                files = [mains_file],
                transitive_files = depset(
                    order = "default",
                    direct = [ctx.executable._java],
                    transitive = [java_info.transitive_runtime_deps],
                ),
                collect_default = True,
            ),
        ),
    ]
