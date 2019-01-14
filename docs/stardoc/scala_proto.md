<a name="#scala_proto_library"></a>
## scala_proto_library

<pre>
scala_proto_library(<a href="#scala_proto_library-name">name</a>, <a href="#scala_proto_library-deps">deps</a>)
</pre>



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
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_proto_toolchain"></a>
## scala_proto_toolchain

<pre>
scala_proto_toolchain(<a href="#scala_proto_toolchain-name">name</a>, <a href="#scala_proto_toolchain-compiler">compiler</a>, <a href="#scala_proto_toolchain-compiler_supports_workers">compiler_supports_workers</a>)
</pre>



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
      </td>
    </tr>
    <tr id="scala_proto_toolchain-compiler_supports_workers">
      <td><code>compiler_supports_workers</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
  </tbody>
</table>


## _scala_proto_toolchain_implementation

<pre>
_scala_proto_toolchain_implementation(<a href="#_scala_proto_toolchain_implementation-ctx">ctx</a>)
</pre>



### Parameters

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="_scala_proto_toolchain_implementation-ctx>
      <td><code>ctx</code></td>
      <td>
        required.
      </td>
    </tr>
  </tbody>
</table>


