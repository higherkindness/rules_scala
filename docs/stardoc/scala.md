<a name="#_scalac_library"></a>
## _scalac_library

<pre>
_scalac_library(name, deps, macro, runtime_deps, scala, srcs)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#_scalac_library_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#_scalac_library_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#_scalac_library_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#_scalac_library_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#_scalac_library_scala">
      <td><code>scala</code></td>
      <td>
        Label; required
      </td>
    </tr>
    <tr id="#_scalac_library_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_library"></a>
## scala_library

<pre>
scala_library(name, data, deps, deps_used_whitelist, exports, javacopts, macro, neverlink, plugins, resource_jars, resource_strip_prefix, resources, runtime_deps, scala, scalacopts, srcs)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_library_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_data">
      <td><code>data</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_library_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#scala_library_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#scala_library_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="#scala_library_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_library_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_library_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_library_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_binary"></a>
## scala_binary

<pre>
scala_binary(name, data, deps, deps_used_whitelist, exports, javacopts, jvm_flags, macro, main_class, plugins, resource_jars, resource_strip_prefix, resources, runtime_deps, scala, scalacopts, srcs)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_binary_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_data">
      <td><code>data</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_binary_jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_binary_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#scala_binary_main_class">
      <td><code>main_class</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="#scala_binary_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="#scala_binary_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_binary_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_binary_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_binary_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_test"></a>
## scala_test

<pre>
scala_test(name, data, deps, deps_used_whitelist, exports, frameworks, isolation, javacopts, jvm_flags, macro, plugins, resource_jars, resource_strip_prefix, resources, runner, runtime_deps, scala, scalacopts, shared_deps, srcs)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_test_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_data">
      <td><code>data</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_frameworks">
      <td><code>frameworks</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_test_isolation">
      <td><code>isolation</code></td>
      <td>
        String; optional
        <p>
          The isolation level to apply
        </p>
      </td>
    </tr>
    <tr id="#scala_test_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_test_jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_test_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#scala_test_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="#scala_test_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_runner">
      <td><code>runner</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_test_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_test_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_test_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_test_shared_deps">
      <td><code>shared_deps</code></td>
      <td>
        List of labels; optional
        <p>
          If isolation is "classloader", the list of deps to keep loaded between tests
        </p>
      </td>
    </tr>
    <tr id="#scala_test_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_repl"></a>
## scala_repl

<pre>
scala_repl(name, data, deps, jvm_flags, scala, scalacopts)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_repl_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_repl_data">
      <td><code>data</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_repl_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_repl_jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scala_repl_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_repl_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_import"></a>
## scala_import

<pre>
scala_import(name, deps, exports, jars, neverlink, runtime_deps, srcjar)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_import_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_import_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_import_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_import_jars">
      <td><code>jars</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_import_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#scala_import_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scala_import_srcjar">
      <td><code>srcjar</code></td>
      <td>
        Label; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scaladoc"></a>
## scaladoc

<pre>
scaladoc(name, compiler_deps, deps, scala, scalacopts, srcs, title)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scaladoc_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scaladoc_compiler_deps">
      <td><code>compiler_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scaladoc_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scaladoc_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scaladoc_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
    <tr id="#scaladoc_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#scaladoc_title">
      <td><code>title</code></td>
      <td>
        String; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_runner_toolchain"></a>
## scala_runner_toolchain

<pre>
scala_runner_toolchain(name, encoding, runner, scalacopts)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_runner_toolchain_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_runner_toolchain_encoding">
      <td><code>encoding</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="#scala_runner_toolchain_runner">
      <td><code>runner</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_runner_toolchain_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_deps_toolchain"></a>
## scala_deps_toolchain

<pre>
scala_deps_toolchain(name, direct, runner, used)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scala_deps_toolchain_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scala_deps_toolchain_direct">
      <td><code>direct</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="#scala_deps_toolchain_runner">
      <td><code>runner</code></td>
      <td>
        Label; optional
      </td>
    </tr>
    <tr id="#scala_deps_toolchain_used">
      <td><code>used</code></td>
      <td>
        String; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#_configure_basic_scala"></a>
## _configure_basic_scala

<pre>
_configure_basic_scala(name, compiler_classpath, runtime_classpath, version)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#_configure_basic_scala_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#_configure_basic_scala_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#_configure_basic_scala_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#_configure_basic_scala_version">
      <td><code>version</code></td>
      <td>
        String; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#_configure_scala"></a>
## _configure_scala

<pre>
_configure_scala(name, compiler_bridge, compiler_classpath, runtime_classpath, version)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#_configure_scala_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#_configure_scala_compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        Label; required
      </td>
    </tr>
    <tr id="#_configure_scala_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#_configure_scala_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#_configure_scala_version">
      <td><code>version</code></td>
      <td>
        String; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#<unknown name>"></a>
## <unknown name>

<pre>
<unknown name>(name, compiler_bridge)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#<unknown name>_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#<unknown name>_compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        Label; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#<unknown name>"></a>
## <unknown name>

<pre>
<unknown name>(name, compiler_classpath, runtime_classpath, version)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#<unknown name>_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#<unknown name>_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#<unknown name>_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#<unknown name>_version">
      <td><code>version</code></td>
      <td>
        String; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#<unknown name>"></a>
## <unknown name>

<pre>
<unknown name>(name, configurations)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#<unknown name>_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#<unknown name>_configurations">
      <td><code>configurations</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#<unknown name>"></a>
## <unknown name>

<pre>
<unknown name>(name, deps, macro, main_class, runtime_deps, scala, srcs)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#<unknown name>_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#<unknown name>_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#<unknown name>_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
      </td>
    </tr>
    <tr id="#<unknown name>_main_class">
      <td><code>main_class</code></td>
      <td>
        String; required
      </td>
    </tr>
    <tr id="#<unknown name>_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
    <tr id="#<unknown name>_scala">
      <td><code>scala</code></td>
      <td>
        Label; required
      </td>
    </tr>
    <tr id="#<unknown name>_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#_ScalaConfiguration"></a>
## _ScalaConfiguration

Provides access to the Scala compiler jars

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#_ScalaConfiguration_version">
      <td><code>version</code></td>
      <td>
        <p>the Scala full version</p>
      </td>
    </tr>
    <tr id="#_ScalaConfiguration_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        <p>the compiler classpath</p>
      </td>
    </tr>
    <tr id="#_ScalaConfiguration_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        <p>the minimal runtime classpath</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#_ZincConfiguration"></a>
## _ZincConfiguration

Provides additional items needed by Zinc

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#_ZincConfiguration_compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        <p>the compiled Zinc compiler bridge</p>
      </td>
    </tr>
  </tbody>
</table>


