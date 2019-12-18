<a name="#configure_zinc_scala"></a>

## configure_zinc_scala

<pre>
configure_zinc_scala(<a href="#configure_zinc_scala-name">name</a>, <a href="#configure_zinc_scala-compiler_bridge">compiler_bridge</a>, <a href="#configure_zinc_scala-compiler_classpath">compiler_classpath</a>, <a href="#configure_zinc_scala-deps_direct">deps_direct</a>, <a href="#configure_zinc_scala-deps_used">deps_used</a>, <a href="#configure_zinc_scala-global_plugins">global_plugins</a>, <a href="#configure_zinc_scala-global_scalacopts">global_scalacopts</a>, <a href="#configure_zinc_scala-runtime_classpath">runtime_classpath</a>, <a href="#configure_zinc_scala-version">version</a>)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="configure_zinc_scala-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="configure_zinc_scala-compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; required
      </td>
    </tr>
    <tr id="configure_zinc_scala-compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; required
      </td>
    </tr>
    <tr id="configure_zinc_scala-deps_direct">
      <td><code>deps_direct</code></td>
      <td>
        String; optional
        <p>
          Options are <code>error</code> and <code>off</code>.
        </p>
      </td>
    </tr>
    <tr id="configure_zinc_scala-deps_used">
      <td><code>deps_used</code></td>
      <td>
        String; optional
        <p>
          Options are <code>error</code> and <code>off</code>.
        </p>
      </td>
    </tr>
    <tr id="configure_zinc_scala-global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          Scalac plugins that will always be enabled.
        </p>
      </td>
    </tr>
    <tr id="configure_zinc_scala-global_scalacopts">
      <td><code>global_scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          Scalac options that will always be enabled.
        </p>
      </td>
    </tr>
    <tr id="configure_zinc_scala-runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; required
      </td>
    </tr>
    <tr id="configure_zinc_scala-version">
      <td><code>version</code></td>
      <td>
        String; required
      </td>
    </tr>
  </tbody>
</table>
