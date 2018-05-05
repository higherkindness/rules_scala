scala_proto_library_private_attributes = {}

def scala_proto_library_implementation(ctx):
    proto_deps = [dep for dep in ctx.attr.deps if hasattr(dep, "proto")]
    if proto_deps != ctx.attr.deps:
        fail("disallowed non proto deps in %s" % ctx.attr.deps)

    protos = [dep.proto for dep in proto_deps]

    transitive_sources = depset(transitive = [proto.transitive_sources for proto in protos])
    transitive_proto_path = depset(transitive = [proto.transitive_proto_path for proto in protos])

    compiler = ctx.toolchains["@rules_scala_annex//rules/scala_proto:compiler_toolchain_type"]

    compiler_inputs, _, input_manifests = ctx.resolve_command(tools = [compiler.compiler])

    srcjar = ctx.outputs.srcjar

    args = ctx.actions.args()
    args.add("--output_srcjar")
    args.add(srcjar)
    args.add("--")
    args.add(transitive_sources)

    if compiler.compiler_supports_workers:
        supports_workers = "1"
    else:
        supports_workers = "0"

    ctx.actions.run(
        mnemonic = "ScalaProtoCompile",
        inputs = depset(direct = [], transitive = [transitive_sources]),
        outputs = [srcjar],
        executable = compiler.compiler.files_to_run.executable,
        input_manifests = input_manifests,
        execution_requirements = {"supports-workers": supports_workers},
        arguments = [args],
    )
