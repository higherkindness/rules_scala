def scala_import_implementation(ctx):

    s_deps = java_common.merge([
        entry[JavaInfo]
        for entry in ctx.attr.deps
        if JavaInfo in entry])

    s_exports = java_common.merge([
        entry[JavaInfo]
        for entry in ctx.attr.exports
        if JavaInfo in entry])

    direct_binary_jars = []
    for jar in ctx.attr.jars:
        for file in jar.files:
            if not file.basename.endswith("-sources.jar"):
                direct_binary_jars += [file]

    compile_time_jars = depset(
        direct = direct_binary_jars)

    transitive_compile_time_jars = depset(
        direct = direct_binary_jars,
        transitive = [
            s_deps.transitive_compile_time_jars,
            s_exports.transitive_compile_time_jars])

    transitive_runtime_jars = depset(
        direct = direct_binary_jars,
        transitive = [
            s_deps.transitive_runtime_jars,
            s_exports.transitive_runtime_jars])

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
