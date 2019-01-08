#
# PHASE: library_defaultinfo
#
# Creates DefaultInfo for Scala libraries
#

def phase_library_defaultinfo(ctx, g):
    g.out.providers.append(DefaultInfo(
        files = depset([ctx.outputs.jar]),
    ))
