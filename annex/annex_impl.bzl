load(":utils.bzl", utils = "root")

common_attrs = {
    "srcs": attr.label_list(allow_files = [".scala", ".srcjar", ".java"]),
    "deps": attr.label_list(),
    "plugins": attr.label_list(allow_files = [".jar"]),
    "runtime_deps": attr.label_list(),
    "data": attr.label_list(allow_files = True, cfg = "data"),
    "resources": attr.label_list(allow_files = True),
    "resource_strip_prefix": attr.string(),
    "resource_jars": attr.label_list(allow_files = True),
    "scalacopts": attr.string_list(),
    "javacopts": attr.string_list(),
    "jvm_flags": attr.string_list(),
    "scalac_jvm_flags": attr.string_list(),
    "javac_jvm_flags": attr.string_list(),
}

scala_annex_test_attrs = {}
scala_annex_test_attrs.update(common_attrs)
scala_annex_test_outputs = {}

def scala_annex_test_implementation(ctx):
    runner = ctx.new_file("%s_annex_test_runner.sh" % ctx.label.name)
    ctx.file_action(
        output = runner,
        content = utils.strip_margin("""
          |#!/bin/bash
          |echo "HELLO"
          |sleep 1
          |echo "WORLD"
          |"""),
        executable = True
    )
    return [
        DefaultInfo(
            executable = runner,
            runfiles = ctx.runfiles([
                runner
            ]),
        ),
    ]

root = struct(
    scala_annex_test = struct(
        implementation = scala_annex_test_implementation,
        attrs = scala_annex_test_attrs,
        outputs = scala_annex_test_outputs,
    ),
)
