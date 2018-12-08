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
    pos = trimmed.find(delim, end = 1)
    if pos == 0:
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
        extra = ""):
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

    ctx.actions.expand_template(
        template = template,
        output = output,
        substitutions = {
            "%classpath%": classpath,
            "%java_start_class%": main_class,
            "%javabin%": "JAVABIN=\"$JAVA_RUNFILES/{}/{}\"\n{}".format(ctx.workspace_name, ctx.executable._java.short_path, extra),
            "%jvm_flags%": jvm_flags,
            "%needs_runfiles%": "1" if runfiles_enabled else "",
            "%runfiles_manifest_only%": "1" if runfiles_enabled else "",
            "%set_jacoco_metadata%": "",
            "%set_jacoco_main_class%": "",
            "%set_jacoco_java_runfiles_root%": "",
            "%workspace_prefix%": ctx.workspace_name + "/",
        },
        is_executable = True,
    )

    return [classpath_file]

def safe_name(value):
    return "".join([value[i] if value[i].isalnum() or value[i] == "." else "_" for i in range(len(value))])

def _short_path(file):
    return file.short_path

def action_singlejar(
        ctx,
        inputs,
        output,
        phantom_inputs = depset(),
        main_class = None,
        progress_message = None):
    # This calls bazels singlejar utility.
    # For a full list of available command line options see:
    # https://github.com/bazelbuild/bazel/blob/master/src/java_tools/singlejar/java/com/google/devtools/build/singlejar/SingleJar.java#L311

    args = ctx.actions.args()
    args.add("--exclude_build_data")
    args.add("--normalize")
    args.add_all("--sources", inputs)
    args.add("--output", output)
    args.add("--warn_duplicate_resources")
    if main_class != None:
        args.add("--main_class", main_class)
        args.set_param_file_format("multiline")
        args.use_param_file("@%s", use_always = True)

    if type(inputs) == "list":
        inputs = depset(inputs)
    if type(phantom_inputs) == "list":
        phantom_inputs = depset()

    all_inputs = depset(transitive = [inputs, phantom_inputs])

    ctx.actions.run(
        arguments = [args],
        executable = ctx.executable._singlejar,
        execution_requirements = {"supports-workers": "1"},
        mnemonic = _SINGLE_JAR_MNEMONIC,
        inputs = all_inputs,
        outputs = [output],
        progress_message = progress_message,
    )
