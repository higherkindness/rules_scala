load(
    ":private/phases.bzl",
    _phase_binary_deployjar = "phase_binary_deployjar",
    _phase_binary_launcher = "phase_binary_launcher",
    _phase_boostrap_compile = "phase_boostrap_compile",
    _phase_coda = "phase_coda",
    _phase_compile = "phase_compile",
    _phase_depscheck = "phase_depscheck",
    _phase_ijinfo = "phase_ijinfo",
    _phase_javainfo = "phase_javainfo",
    _phase_library_defaultinfo = "phase_library_defaultinfo",
    _phase_resources = "phase_resources",
    _phase_singlejar = "phase_singlejar",
    _phase_test_launcher = "phase_test_launcher",
    _run_phases = "run_phases",
)

scala_library_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("library_defaultinfo", _phase_library_defaultinfo),
    ("coda", _phase_coda),
]

scala_binary_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("binary_deployjar", _phase_binary_deployjar),
    ("binary_launcher", _phase_binary_launcher),
    ("coda", _phase_coda),
]

scala_test_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_compile),
    ("depscheck", _phase_depscheck),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("test_launcher", _phase_test_launcher),
    ("coda", _phase_coda),
]

bootstrap_scala_library_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_boostrap_compile),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("library_defaultinfo", _phase_library_defaultinfo),
    ("coda", _phase_coda),
]

bootstrap_scala_binary_phases = [
    ("javainfo", _phase_javainfo),
    ("resources", _phase_resources),
    ("compile", _phase_boostrap_compile),
    ("singlejar", _phase_singlejar),
    ("ijinfo", _phase_ijinfo),
    ("binary_deployjar", _phase_binary_deployjar),
    ("binary_launcher", _phase_binary_launcher),
    ("coda", _phase_coda),
]

def scala_library_implementation(ctx):
    return _run_phases(ctx, scala_library_phases).coda

def scala_binary_implementation(ctx):
    return _run_phases(ctx, scala_binary_phases).coda

def scala_test_implementation(ctx):
    return _run_phases(ctx, scala_test_phases).coda

def bootstrap_scala_library_implementation(ctx):
    return _run_phases(ctx, bootstrap_scala_library_phases).coda

def bootstrap_scala_binary_implementation(ctx):
    return _run_phases(ctx, bootstrap_scala_binary_phases).coda

runner_common_attributes = {
    "_java_toolchain": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_toolchain"),
    ),
    "_host_javabase": attr.label(
        default = Label("@bazel_tools//tools/jdk:current_java_runtime"),
        cfg = "host",
    ),
    "_singlejar": attr.label(
        cfg = "host",
        default = "@bazel_tools//tools/jdk:singlejar",
        executable = True,
    ),
    "_zipper": attr.label(
        cfg = "host",
        default = "@bazel_tools//tools/zip:zipper",
        executable = True,
    ),
}

scala_library_private_attributes = runner_common_attributes

scala_binary_private_attributes = dict(
    {
        "_java": attr.label(
            default = Label("@bazel_tools//tools/jdk:java"),
            executable = True,
            cfg = "host",
        ),
        "_java_stub_template": attr.label(
            default = Label("@anx_java_stub_template//file"),
            allow_single_file = True,
        ),
    },
    **runner_common_attributes
)

scala_test_private_attributes = scala_binary_private_attributes

bootstrap_scala_library_private_attributes = dict(
    {
        "_java": attr.label(
            default = Label("@bazel_tools//tools/jdk:java"),
            executable = True,
            cfg = "host",
        ),
        "_jar_creator": attr.label(
            default = Label("@rules_scala_annex//rules/common/third_party/bazel/src/java_tools/buildjar/java/com/google/devtools/build/buildjar/jarhelper:jarcreator_bin"),
            executable = True,
            cfg = "host",
        ),
    },
    **runner_common_attributes
)

bootstrap_scala_binary_private_attributes = dict(
    {
        "_java_stub_template": attr.label(
            default = Label("@anx_java_stub_template//file"),
            allow_single_file = True,
        ),
    },
    **bootstrap_scala_library_private_attributes
)
