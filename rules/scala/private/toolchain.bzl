def annex_scala_runner_toolchain_implementation(ctx):
    return [platform_common.ToolchainInfo(
        runner = ctx.attr.runner,
    )]
