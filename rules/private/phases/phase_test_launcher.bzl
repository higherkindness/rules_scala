load(
    "@rules_scala_annex//rules/private:jacoco.bzl",
    _jacoco_info = "jacoco_info",
)

load(
    "//rules/common:private/utils.bzl",
    _action_singlejar = "action_singlejar",
    _collect = "collect",
    #_strip_margin = "strip_margin",
    _write_launcher = "write_launcher",
)

def _instrumented_jars_impl(target, ctx):
    if JavaInfo not in target:
        return []

    return [
        _jacoco_info.merge(
            getattr(ctx.rule.attr, "deps", []) +
            getattr(ctx.rule.attr, "exports", []) +
            getattr(ctx.rule.attr, "runtime_deps", [])
        )
    ]

instrumented_jars = aspect(
    attr_aspects = ["deps", "exports", "runtime_deps"],
    implementation = _instrumented_jars_impl,
)

#
# PHASE: test_launcher
#
# Writes a Scala test launcher
#

def phase_test_launcher(ctx, g):
    files = ctx.files._java + [g.compile.zinc_info.apis]

    replacement_jars = {}
    if ctx.configuration.coverage_enabled:
        replacement_jars = _jacoco_info.merge(getattr(ctx.attr, "deps", [])).replacements

    test_jars = g.javainfo.java_info.transitive_runtime_deps
    test_jars = depset([
        replacement_jars[jar] if jar in replacement_jars else jar
        for jar in test_jars
    ])

    print(test_jars)

    runner_jars = ctx.attr.runner[JavaInfo].transitive_runtime_deps
    all_jars = [test_jars, runner_jars]

    args = ctx.actions.args()
    args.add("--apis", g.compile.zinc_info.apis.short_path)
    args.add_all("--frameworks", ctx.attr.frameworks)
    if ctx.attr.isolation == "classloader":
        shared_deps = java_common.merge(_collect(JavaInfo, ctx.attr.shared_deps))
        args.add("--isolation", "classloader")
        args.add_all("--shared_classpath", shared_deps.transitive_runtime_deps, map_each = _test_launcher_short_path)
    elif ctx.attr.isolation == "process":
        subprocess_executable = ctx.actions.declare_file("{}/subprocess".format(ctx.label.name))
        subprocess_runner_jars = ctx.attr.subprocess_runner[JavaInfo].transitive_runtime_deps
        all_jars.append(subprocess_runner_jars)
        files += _write_launcher(
            ctx,
            "{}/subprocess-".format(ctx.label.name),
            subprocess_executable,
            subprocess_runner_jars,
            "higherkindness.rules_scala.common.sbt_testing.SubprocessTestRunner",
            [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags],
        )
        files.append(subprocess_executable)
        args.add("--isolation", "process")
        args.add("--subprocess_exec", subprocess_executable.short_path)
    args.add_all("--", test_jars, map_each = _test_launcher_short_path)
    args.set_param_file_format("multiline")
    args_file = ctx.actions.declare_file("{}/test.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    files.append(args_file)

    files += _write_launcher(
        ctx,
        "{}/".format(ctx.label.name),
        ctx.outputs.bin,
        runner_jars,
        "higherkindness.rules_scala.workers.zinc.test.TestRunner",
        [ctx.expand_location(f, ctx.attr.data) for f in ctx.attr.jvm_flags] + [
            "-Dbazel.runPath=$RUNPATH",
            "-DscalaAnnex.test.args=${{RUNPATH}}{}".format(args_file.short_path),
        ],
    )

    g.out.providers.append(DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset([ctx.outputs.jar]),
        runfiles = ctx.runfiles(
            collect_data = True,
            collect_default = True,
            files = files,
            transitive_files = depset([], transitive = all_jars),
        ),
    ))

def _test_launcher_short_path(file):
    return file.short_path
