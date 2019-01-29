def phase_coverage_jacoco(ctx, g):
    if not ctx.configuration.coverage_enabled:
        return
