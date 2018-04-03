 licenses(["notice"])
# Copyright 2014 The Bazel Authors. Licensed under Apache License, Version 2.0

java_library(
    name = "jarhelper",
    srcs = [
        "JarCreator.java",
        "JarHelper.java",
    ],
    visibility = ["//visibility:public"],
)

java_binary(
    name = "jarcreator_bin",
    runtime_deps = [":jarhelper"],
    main_class = "com.google.devtools.build.buildjar.jarhelper.JarCreator",
    visibility = ["//visibility:public"],
)

