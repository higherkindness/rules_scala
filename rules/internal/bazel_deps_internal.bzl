def scala_import_implementation(ctx):

    _compile_time_jars_direct = [
        depset(direct = [
            file for file in jar.files
            if not file.basename.endswith("-sources.jar")
        ])
        for jar in ctx.attr.jars]
    _compile_time_jars_exported = [
        entry[JavaInfo].compile_jars
        for entry in ctx.attr.exports
        if JavaInfo in entry]
    compile_time_jars = depset(
        transitive =
        _compile_time_jars_direct +
        _compile_time_jars_exported)

    _transitive_compile_time_jars_direct = [
        entry[JavaInfo].transitive_compile_time_jars
        for entry in ctx.attr.deps
        if JavaInfo in entry]
    _transitive_compile_time_jars_exported = [
        entry[JavaInfo].transitive_compile_time_jars
        for entry in ctx.attr.exports
        if JavaInfo in entry]
    transitive_compile_time_jars = depset(
        transitive =
        _transitive_compile_time_jars_direct +
        _transitive_compile_time_jars_exported)

    _transitive_runtime_jars_direct = [
        entry[JavaInfo].transitive_runtime_jars
        for entry in ctx.attr.runtime_deps
        if JavaInfo in entry]
    _transitive_runtime_jars_exported = [
        entry[JavaInfo].transitive_runtime_jars
        for entry in ctx.attr.exports
        if JavaInfo in entry]
    transitive_runtime_jars = depset(
        transitive =
        _transitive_runtime_jars_direct +
        _transitive_runtime_jars_exported)

    # TODO:
    # consider exposing a ScalaInfo provider here too
    # we'd need to infer the scala version from the jar file names

    return [java_common.create_provider(
        ctx.actions,
        use_ijar = False,
        compile_time_jars = compile_time_jars,
        transitive_compile_time_jars = transitive_compile_time_jars,
        transitive_runtime_jars = transitive_runtime_jars,
    )]
