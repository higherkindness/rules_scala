def annex_scala_deps_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        runner = ctx.attr.runner,
        flags = ctx.attr.flags,
    )]

def annex_scala_runner_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        runner = ctx.attr.runner,
        scalacopts = ctx.attr.scalacopts,
    )]
