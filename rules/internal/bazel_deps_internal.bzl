def scala_import_implementation(ctx):
    if (ctx.attr.exports != []): fail("exports not supported yet")

    compile_time_jars = depset(transitive = [
        depset(direct = [
            file for file in jar.files
            if not file.basename.endswith("-sources.jar")
        ])
        for jar in ctx.attr.jars
    ])

    transitive_compile_time_jars = depset(transitive = [
        entry[JavaInfo].transitive_compile_time_jars
        for entry in ctx.attr.deps
        if JavaInfo in entry
    ])

    runtime_jars = depset(transitive = [
        entry[JavaInfo].transitive_runtime_jars
        for entry in ctx.attr.runtime_deps
        if JavaInfo in entry
    ])

    # TODO:
    # consider exposing a ScalaInfo provider here too
    # we'd need to infer the scala version from the jar file names

    return [java_common.create_provider(
        ctx.actions,
        use_ijar = False,
        compile_time_jars = compile_time_jars,
        transitive_compile_time_jars = transitive_compile_time_jars,
        runtime_jars = runtime_jars,
    )]
