<a name="#scala_proto_library"></a>
## scala_proto_library

<pre>
scala_proto_library(name, deps)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_proto_library_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_proto_library_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_proto_toolchain"></a>
## scala_proto_toolchain

<pre>
scala_proto_toolchain(name, compiler, compiler_supports_workers)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_proto_toolchain_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_proto_toolchain_compiler">
      <td><code>compiler</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_proto_toolchain_compiler_supports_workers">
      <td><code>compiler_supports_workers</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
  </tbody>
</table>


