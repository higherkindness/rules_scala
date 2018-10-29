#
# Helper utilities
#

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

def write_launcher(
        ctx,
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
    classpath_file = ctx.actions.declare_file("{}/classpath.params".format(ctx.label.name))
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
