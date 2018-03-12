load("//annex:annex.bzl", "scala_annex_toolchain")

toolchain_type(
        name = 'scala_annex_toolchain_type',
        visibility = ["//visibility:public"],
)

scala_annex_toolchain(
        name = 'scala_2_12_4_toolchain_impl',
        compiler_classpath = [
                '@scala_compiler_2_12_4//jar',                
                '@scala_reflect_2_12_4//jar',
                '@scala_library_2_12_4//jar',
        ],
        compiler_bridge = '@compiler_bridge_2_12//jar',
        compiler_bridge_classpath = [
                '@compiler_interface//jar',
                '@util_interface//jar',
        ],
        binary_version = '2.12',
        visibility = ["//visibility:public"],
)

toolchain(
        name = 'scala_2_12_4_toolchain',
        toolchain_type = ':scala_annex_toolchain_type',
        toolchain = ':scala_2_12_4_toolchain_impl',
        visibility = ["//visibility:public"],
)
