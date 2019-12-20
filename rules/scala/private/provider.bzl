load(
    "@rules_scala_annex//rules:providers.bzl",
    _CodeCoverageConfiguration = "CodeCoverageConfiguration",
    _DepsConfiguration = "DepsConfiguration",
    _ScalaConfiguration = "ScalaConfiguration",
    _ScalaRulePhase = "ScalaRulePhase",
    _ZincConfiguration = "ZincConfiguration",
)
load(
    "//rules/private:phases.bzl",
    _phase_bootstrap_compile = "phase_bootstrap_compile",
    _phase_zinc_compile = "phase_zinc_compile",
    _phase_zinc_depscheck = "phase_zinc_depscheck",
)

def configure_bootstrap_scala_implementation(ctx):
    return [
        _ScalaConfiguration(
            compiler_classpath = ctx.attr.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
            global_scalacopts = ctx.attr.global_scalacopts,
            runtime_classpath = ctx.attr.runtime_classpath,
            version = ctx.attr.version,
        ),
        _ScalaRulePhase(
            phases = [
                ("=", "compile", "compile", _phase_bootstrap_compile),
            ],
        ),
    ]

def configure_zinc_scala_implementation(ctx):
    return [
        _ScalaConfiguration(
            compiler_classpath = ctx.attr.compiler_classpath,
            global_plugins = ctx.attr.global_plugins,
            global_scalacopts = ctx.attr.global_scalacopts,
            runtime_classpath = ctx.attr.runtime_classpath,
            version = ctx.attr.version,
        ),
        _CodeCoverageConfiguration(
            instrumentation_worker = ctx.attr._code_coverage_instrumentation_worker,
        ),
        _ZincConfiguration(
            compile_worker = ctx.attr._compile_worker,
            compiler_bridge = ctx.file.compiler_bridge,
            log_level = ctx.attr.log_level,
        ),
        _DepsConfiguration(
            direct = ctx.attr.deps_direct,
            used = ctx.attr.deps_used,
            worker = ctx.attr._deps_worker,
        ),
        _ScalaRulePhase(
            phases = [
                ("=", "compile", "compile", _phase_zinc_compile),
                ("+", "compile", "depscheck", _phase_zinc_depscheck),
            ],
        ),
    ]
