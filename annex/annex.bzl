load(":annex_impl.bzl", _ = "root")

scala_annex_test = rule(
    implementation = _.scala_annex_test.implementation,
    attrs = _.scala_annex_test.attrs,
    outputs = _.scala_annex_test.outputs,
    executable = True,
    test = True,
    fragments = ["java"],
    toolchains = ['@io_bazel_rules_scala//scala:toolchain_type'],
)

scala_annex_toolchain = rule(
    implementation = _.scala_annex_toolchain.implementation,
    attrs = _.scala_annex_toolchain.attrs,
    #fragments = ["java"],
    #host_fragments = ["java"],
)
