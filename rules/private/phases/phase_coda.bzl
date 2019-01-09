#
# PHASE: coda
#
# Creates the final rule return structure
#

def phase_coda(ctx, g):
    return struct(
        java = g.ijinfo.intellij_info,
        providers = g.out.providers,
    )
