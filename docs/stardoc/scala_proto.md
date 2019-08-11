<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#scala_proto_library"></a>

## scala_proto_library

<pre>
scala_proto_library(<a href="#scala_proto_library-name">name</a>, <a href="#scala_proto_library-deps">deps</a>)
</pre>


Generates Scala code from proto sources. The output is a `.srcjar` that can be passed into other rules for compilation.

See example use in [/tests/proto/BUILD](/tests/proto/BUILD)


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="scala_proto_library-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="scala_proto_library-deps">
      <td><code>deps</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          The proto_library targets you wish to generate Scala from
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_proto_toolchain"></a>

## scala_proto_toolchain

<pre>
scala_proto_toolchain(<a href="#scala_proto_toolchain-name">name</a>, <a href="#scala_proto_toolchain-compiler">compiler</a>, <a href="#scala_proto_toolchain-compiler_supports_workers">compiler_supports_workers</a>, <a href="#scala_proto_toolchain-generator_params">generator_params</a>)
</pre>


Specifies a toolchain of the `@rules_scala_annex//rules/scala_proto:compiler_toolchain_type` toolchain type.

This rule should be used with an accompanying `toolchain` that binds it and specifies constraints
(See the official documentation for more info on [Bazel Toolchains](https://docs.bazel.build/versions/master/toolchains.html))

For example:

```python
scala_proto_toolchain(
    name = "scalapb_toolchain_example",
    compiler = ":worker",
    compiler_supports_workers = True,
    generator_params = "grpc,java_conversions",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "scalapb_toolchain_example_linux",
    toolchain = ":scalapb_toolchain_example",
    toolchain_type = "@rules_scala_annex//rules/scala_proto:compiler_toolchain_type",
    exec_compatible_with = [
        "@bazel_tools//platforms:linux",
        "@bazel_tools//platforms:x86_64",
    ],
    target_compatible_with = [
        "@bazel_tools//platforms:linux",
        "@bazel_tools//platforms:x86_64",
    ],
    visibility = ["//visibility:public"],
)
```


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="scala_proto_toolchain-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="scala_proto_toolchain-compiler">
      <td><code>compiler</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; optional
        <p>
          The compiler to use to generate Scala form proto sources
        </p>
      </td>
    </tr>
    <tr id="scala_proto_toolchain-compiler_supports_workers">
      <td><code>compiler_supports_workers</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="scala_proto_toolchain-generator_params">
      <td><code>generator_params</code></td>
      <td>
        String; optional
        <p>
          Generator params to pass to the scala PB compiler (ie java_conversions, flat_package, grpc)
        </p>
      </td>
    </tr>
  </tbody>
</table>


