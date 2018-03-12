load("//annex:utils.bzl", utils = "root")

def _toolchain_test_rule_impl(ctx):
    #path = ctx.actions.declare_file("%s.out" % ctx.label.name)

    path = ctx.outputs.out

    toolchain = ctx.toolchains['//annex:scala_annex_toolchain_type']

    ctx.actions.run_shell(
        outputs = [path],
        inputs = [toolchain.compiler_bridge],
        command = utils.strip_margin("""
          |#!/bin/bash
          |echo "Woop:" {woop}
          |sleep 1
          |cp {woop} {out}
          |""".format(
              woop = toolchain.compiler_bridge.path,
              out = path.path)),
    )


toolchain_test_rule = rule(
    implementation = _toolchain_test_rule_impl,
    toolchains = ['//annex:scala_annex_toolchain_type'],
    outputs = {"out": "%{name}.txt"},
)
