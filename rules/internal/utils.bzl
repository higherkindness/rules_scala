#
# Helper utilities
#

def merge_dicts(*args):
    """
    Merges any number of dictionaries
    """
    res = {}
    for arg in args:
        res.update(arg)
    return res

def strip_margin(str, delim = "|"):
    """
    For every line in str:
      Strip a leading prefix consisting of spaces followed by delim from the line.
    This is extremely similar to Scala's .stripMargin
    """
    return "\n".join([
        _strip_margin_line(line, delim) for line in str.splitlines()
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
        current_version = None
):
    if not current_version: current_version = native.bazel_version

    required_nums = _version_tuple(required_version)
    current_nums  = _version_tuple(current_version)

    for r, c in zip(required_nums, current_nums):
        if c > r:
            break
        elif r == c:
            continue
        else:
            fail("bazel version %s or higher required (current = %s)" %
                 (required_version, current_version))

root = struct(
    merge_dicts = merge_dicts,
    strip_margin = strip_margin,
    require_bazel_version = require_bazel_version,
)
