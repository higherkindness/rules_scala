load("@bazel_skylib//lib:dicts.bzl", _dicts = "dicts")

_JacocoInfo = provider(
    fields = {
        "replacements": "hash of files to swap out",
    },
)

_AggregateJacocoInfo = provider(
    fields = {
        "replacements": "hash of files to swap out",
    },
)

def merge(entries, base = {}):
    return _AggregateJacocoInfo(replacements = _dicts.add(base, *([
        entry[_JacocoInfo].replacements
        for entry in entries
        if _JacocoInfo in entry
    ] + [
        entry[_AggregateJacocoInfo].replacements
        for entry in entries
        if _AggregateJacocoInfo in entry
    ])))

jacoco_info = struct(
    aggregate_provider = _AggregateJacocoInfo,
    merge = merge,
    provider = _JacocoInfo,
)
