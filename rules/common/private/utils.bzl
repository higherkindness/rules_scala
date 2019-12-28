load("@bazel_skylib//lib:dicts.bzl", "dicts")
load("@bazel_skylib//lib:paths.bzl", "paths")

#
# Helper utilities
#

def collect(index, iterable):
    return [entry[index] for entry in iterable]

def collect_optionally(index, iterable):
    return [entry[index] for entry in iterable if index in entry]

def strip_margin(str, delim = "|"):
    """
    For every line in str:
      Strip a leading prefix consisting of spaces followed by delim from the line.
    This is extremely similar to Scala's .stripMargin
    """
    return "\n".join([
        _strip_margin_line(line, delim)
        for line in str.splitlines()
    ])

def _strip_margin_line(line, delim):
    trimmed = line.lstrip(" ")
    if trimmed[:1] == delim:
        return trimmed[1:]
    else:
        return line

_SINGLE_JAR_MNEMONIC = "SingleJar"

def write_launcher(
        ctx,
        prefix,
        output,
        runtime_classpath,
        main_class,
        jvm_flags,
        extra = "",
        jacoco_classpath = None):
    """Macro that writes out a launcher script shell script.
      Args:
        runtime_classpath: File containing the classpath required to launch this java target.
        main_class: the main class to launch.
        jvm_flags: The flags that should be passed to the jvm.
        args: Args that should be passed to the Binary.
    """

    classpath_args = ctx.actions.args()
    classpath_args.add_joined(runtime_classpath, format_each = "${RUNPATH}%s", join_with = ":", map_each = _short_path)
    classpath_args.set_param_file_format("multiline")
    classpath_file = ctx.actions.declare_file("{}classpath.params".format(prefix))
    ctx.actions.write(classpath_file, classpath_args)

    classpath = "\"$(eval echo \"$(cat ${{RUNPATH}}{})\")\"".format(classpath_file.short_path)

    jvm_flags = " ".join(jvm_flags)
    template = ctx.file._java_stub_template
    runfiles_enabled = False

    java_executable = ctx.attr._target_jdk[java_common.JavaRuntimeInfo].java_executable_runfiles_path
    java_path = str(java_executable)
    if paths.is_absolute(java_path):
        javabin = java_path
    else:
        javabin = "$JAVA_RUNFILES/{}/{}".format(ctx.workspace_name, java_executable)

    base_substitutions = {
        "%classpath%": classpath,
        "%javabin%": "JAVABIN=\"{}\"\n{}".format(javabin, extra),
        "%jvm_flags%": jvm_flags,
        "%needs_runfiles%": "1" if runfiles_enabled else "",
        "%runfiles_manifest_only%": "1" if runfiles_enabled else "",
        "%workspace_prefix%": ctx.workspace_name + "/",
    }

    if jacoco_classpath != None:
        # this file must end in ".txt" to trigger the `isNewImplementation` paths
        # in com.google.testing.coverage.JacocoCoverageRunner
        metadata_file = ctx.actions.declare_file("%s.jacoco_metadata.txt" % ctx.attr.name, sibling = output)
        ctx.actions.write(metadata_file, "\n".join([
            jar.short_path.replace("../", "external/")
            for jar in jacoco_classpath
        ]))
        more_outputs = [metadata_file]
        more_substitutions = {
            "%java_start_class%": "com.google.testing.coverage.JacocoCoverageRunner",
            "%set_jacoco_metadata%": "export JACOCO_METADATA_JAR=\"$JAVA_RUNFILES/{}/{}\"".format(ctx.workspace_name, metadata_file.short_path),
            "%set_jacoco_main_class%": """export JACOCO_MAIN_CLASS={}""".format(main_class),
            "%set_jacoco_java_runfiles_root%": """export JACOCO_JAVA_RUNFILES_ROOT=$JAVA_RUNFILES/{}/""".format(ctx.workspace_name),
            "%set_java_coverage_new_implementation%": """export JAVA_COVERAGE_NEW_IMPLEMENTATION=YES""",
        }
    else:
        more_outputs = []
        more_substitutions = {
            "%java_start_class%": main_class,
            "%set_jacoco_metadata%": "",
            "%set_jacoco_main_class%": "",
            "%set_jacoco_java_runfiles_root%": "",
            "%set_java_coverage_new_implementation%": "",
        }

    ctx.actions.expand_template(
        template = template,
        output = output,
        substitutions = dicts.add(base_substitutions, more_substitutions),
        is_executable = True,
    )

    return more_outputs + [classpath_file]

def safe_name(value):
    return "".join([value[i] if value[i].isalnum() or value[i] == "." else "_" for i in range(len(value))])

def _short_path(file):
    return file.short_path

# This propagates specific tags as execution requirements to be passed to an action
# A fix to bazelbuild/bazel that will make this no longer necessary is underway; we can remove this once that's released and we've obtained it
PROPAGATABLE_TAGS = ["no-remote", "no-cache", "no-sandbox", "no-remote-exec", "no-remote-cache"]

def resolve_execution_reqs(ctx, base_exec_reqs):
    exec_reqs = {}
    for tag in ctx.attr.tags:
        if tag in PROPAGATABLE_TAGS:
            exec_reqs.update({tag: "1"})
    exec_reqs.update(base_exec_reqs)
    return exec_reqs

def action_singlejar(
        ctx,
        inputs,
        output,
        phantom_inputs = depset(),
        main_class = None,
        progress_message = None,
        resources = {}):
    # This calls bazels singlejar utility.
    # For a full list of available command line options see:
    # https://github.com/bazelbuild/bazel/blob/master/src/java_tools/singlejar/java/com/google/devtools/build/singlejar/SingleJar.java#L311
    # The C++ version is being used now, which does not support workers. This is why workers are disabled for SingleJar

    if type(inputs) == "list":
        inputs = depset(inputs)
    if type(phantom_inputs) == "list":
        phantom_inputs = depset(phantom_inputs)

    args = ctx.actions.args()
    args.add("--exclude_build_data")
    args.add("--normalize")
    args.add_all("--sources", inputs)
    args.add_all("--resources", ["{}:{}".format(value.path, key) for key, value in resources.items()])
    args.add("--output", output)
    if main_class != None:
        args.add("--main_class", main_class)
        args.set_param_file_format("multiline")
        args.use_param_file("@%s", use_always = True)

    all_inputs = depset(resources.values(), transitive = [inputs, phantom_inputs])

    ctx.actions.run(
        arguments = [args],
        executable = ctx.executable._singlejar,
        execution_requirements = resolve_execution_reqs(ctx, {"supports-workers": "0"}),
        mnemonic = _SINGLE_JAR_MNEMONIC,
        inputs = all_inputs,
        outputs = [output],
        progress_message = progress_message,
    )
