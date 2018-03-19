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

root = struct(
    merge_dicts = merge_dicts,
    strip_margin = strip_margin,
)
