#
# PHASE: coda
#
# Creates the final rule return structure
#

def phase_coda(ctx, g):
    dynamic = {}
    if hasattr(g, "coverage"):
        dynamic["instrumented_files"] = g.coverage.instrumented_files

    return struct(
        java = g.ijinfo.intellij_info,
        providers = g.out.providers,
        **dynamic
    )
