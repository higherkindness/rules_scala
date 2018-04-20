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

def _version_tuple(version):
    return [int(n) for n in version.split("-")[0].split(".")]

def require_bazel_version(
        required_version,
        current_version = None):
    if not current_version:
        current_version = native.bazel_version

    required_nums = _version_tuple(required_version)
    current_nums = _version_tuple(current_version)

    for r, c in zip(required_nums, current_nums):
        if c > r:
            break
        elif r == c:
            continue
        else:
            fail("bazel version %s or higher required (current = %s)" %
                 (required_version, current_version))

def write_launcher(
        ctx,
        output,
        runtime_classpath,
        main_class,
        jvm_flags,
        args = "",
        wrapper_preamble = ""):
    """Macro that writes out a launcher script shell script.
      Args:
        runtime_classpath: All of the runtime jars required to launch this java target.
        main_class: the main class to launch.
        jvm_flags: The flags that should be passed to the jvm.
        args: Args that should be passed to the Binary.
    """
    classpath = ":".join(["${RUNPATH}%s" % (j.short_path) for j in runtime_classpath.to_list()])

    #jvm_flags = " ".join([ctx.expand_location(f, ctx.attr.data) for f in jvm_flags])
    jvm_flags = " ".join(jvm_flags)
    template = ctx.attr._java_stub_template.files.to_list()[0]

    runfiles_enabled = False

    ctx.actions.expand_template(
        template = template,
        output = output,
        substitutions = {
            "%classpath%": classpath,
            "%java_start_class%": main_class,
            "%javabin%": "JAVABIN=\"$JAVA_RUNFILES/{}/{}\"".format(ctx.workspace_name, ctx.executable._java.short_path),
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

def safe_name(value):
    return value.replace(".", "_").replace("-", "_")
