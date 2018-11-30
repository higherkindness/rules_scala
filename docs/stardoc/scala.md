<a name="#scala_library"></a>
## scala_library

<pre>
scala_library(name, data, deps, deps_used_whitelist, exports, javacopts, macro, neverlink, plugins, resource_jars, resource_strip_prefix, resources, runtime_deps, scala, scalacopts, srcs)
</pre>

Compiles a Scala JVM library.

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
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM libraries to add as dependencies to any libraries dependent on this one.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library should be excluded at runtime.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
    <tr id="#scala_library_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#bootstrap_scala_library"></a>
## bootstrap_scala_library

<pre>
bootstrap_scala_library(name, data, deps, deps_used_whitelist, exports, javacopts, macro, neverlink, plugins, resource_jars, resource_strip_prefix, resources, runtime_deps, scala, scalacopts, srcs)
</pre>

Compiles a Scala JVM library.

### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#bootstrap_scala_library_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_data">
      <td><code>data</code></td>
      <td>
        List of labels; optional
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM libraries to add as dependencies to any libraries dependent on this one.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library should be excluded at runtime.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_library_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_binary"></a>
## scala_binary

<pre>
scala_binary(name, data, deps, deps_used_whitelist, exports, javacopts, jvm_flags, macro, main_class, neverlink, plugins, resource_jars, resource_strip_prefix, resources, runtime_deps, scala, scalacopts, srcs)
</pre>

Compiles and links a Scala JVM executable.

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
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM libraries to add as dependencies to any libraries dependent on this one.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
        <p>
          The JVM runtime flags.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_main_class">
      <td><code>main_class</code></td>
      <td>
        String; optional
        <p>
          The main class. If not provided, it will be inferred by its type signature.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library should be excluded at runtime.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
    <tr id="#scala_binary_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#bootstrap_scala_binary"></a>
## bootstrap_scala_binary

<pre>
bootstrap_scala_binary(name, data, deps, deps_used_whitelist, exports, javacopts, jvm_flags, macro, main_class, neverlink, plugins, resource_jars, resource_strip_prefix, resources, runtime_deps, scala, scalacopts, srcs)
</pre>

Compiles and links a Scala JVM executable.

### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#bootstrap_scala_binary_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_data">
      <td><code>data</code></td>
      <td>
        List of labels; optional
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM libraries to add as dependencies to any libraries dependent on this one.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_javacopts">
      <td><code>javacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
        <p>
          The JVM runtime flags.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_main_class">
      <td><code>main_class</code></td>
      <td>
        String; required
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library should be excluded at runtime.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
        <p>
          The files to include as classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
    <tr id="#bootstrap_scala_binary_srcs">
      <td><code>srcs</code></td>
      <td>
        List of labels; optional
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_test"></a>
## scala_test

<pre>
scala_test(name, data, deps, deps_used_whitelist, exports, frameworks, isolation, javacopts, jvm_flags, macro, neverlink, plugins, resource_jars, resource_strip_prefix, resources, runner, runtime_deps, scala, scalacopts, shared_deps, srcs, subprocess_runner)
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
        <p>
          The additional runtime files needed by this library.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_deps_used_whitelist">
      <td><code>deps_used_whitelist</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies to always consider used for `scala_deps_used` checks.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_exports">
      <td><code>exports</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM libraries to add as dependencies to any libraries dependent on this one.
        </p>
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
        <p>
          The Javac options.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_jvm_flags">
      <td><code>jvm_flags</code></td>
      <td>
        List of strings; optional
        <p>
          The JVM runtime flags.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_neverlink">
      <td><code>neverlink</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library should be excluded at runtime.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_plugins">
      <td><code>plugins</code></td>
      <td>
        List of labels; optional
        <p>
          The Scalac plugins.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_resource_jars">
      <td><code>resource_jars</code></td>
      <td>
        List of labels; optional
        <p>
          The JARs to merge into the output JAR.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_resource_strip_prefix">
      <td><code>resource_strip_prefix</code></td>
      <td>
        String; optional
        <p>
          The path prefix to strip from classpath resources.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_resources">
      <td><code>resources</code></td>
      <td>
        List of labels; optional
        <p>
          The files to include as classpath resources.
        </p>
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
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scala_test_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
        <p>
          The `ScalaConfiguration`.
        </p>
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
        <p>
          The source Scala and Java files (and `.srcjar` files of those).
        </p>
      </td>
    </tr>
    <tr id="#scala_test_subprocess_runner">
      <td><code>subprocess_runner</code></td>
      <td>
        Label; optional
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
        <p>
          The additional runtime files needed by this REPL.
        </p>
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
        <p>
          The JVM runtime flags.
        </p>
      </td>
    </tr>
    <tr id="#scala_repl_scala">
      <td><code>scala</code></td>
      <td>
        Label; optional
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#scala_repl_scalacopts">
      <td><code>scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          The Scalac options.
        </p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#scala_import"></a>
## scala_import

<pre>
scala_import(name, deps, exports, jars, neverlink, runtime_deps, srcjar)
</pre>


Creates a Scala JVM library.

Use this only for libraries with macros. Otherwise, use `java_import`.


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


Generates Scaladocs.


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

Configures the Scala runner to use.

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

Configures the deps checker and options to use.

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


<a name="#configure_basic_scala"></a>
## configure_basic_scala

<pre>
configure_basic_scala(name, compiler_classpath, global_plugins, runtime_classpath, version)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#configure_basic_scala_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#configure_basic_scala_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#configure_basic_scala_global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        List of labels; optional
        <p>
          Scalac plugins that will always be enabled.
        </p>
      </td>
    </tr>
    <tr id="#configure_basic_scala_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#configure_basic_scala_version">
      <td><code>version</code></td>
      <td>
        String; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#configure_scala"></a>
## configure_scala

<pre>
configure_scala(name, compiler_bridge, compiler_classpath, global_plugins, runtime_classpath, version)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#configure_scala_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#configure_scala_compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        Label; required
      </td>
    </tr>
    <tr id="#configure_scala_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#configure_scala_global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        List of labels; optional
        <p>
          Scalac plugins that will always be enabled.
        </p>
      </td>
    </tr>
    <tr id="#configure_scala_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#configure_scala_version">
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

Creates a `ZincConfiguration`.

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
<unknown name>(name, compiler_classpath, global_plugins, runtime_classpath, version)
</pre>

Creates a `ScalaConfiguration`.

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
    <tr id="#<unknown name>_global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        List of labels; optional
        <p>
          Scalac plugins that will always be enabled.
        </p>
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


<a name="#_ScalaConfiguration"></a>
## _ScalaConfiguration

Scala compile-time and runtime configuration

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
        <p>The Scala full version.</p>
      </td>
    </tr>
    <tr id="#_ScalaConfiguration_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        <p>The compiler classpath.</p>
      </td>
    </tr>
    <tr id="#_ScalaConfiguration_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        <p>The runtime classpath.</p>
      </td>
    </tr>
    <tr id="#_ScalaConfiguration_global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        <p>Globally enabled compiler plugins</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#_ZincConfiguration"></a>
## _ZincConfiguration

Zinc configuration.

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
        <p>compiled Zinc compiler bridge</p>
      </td>
    </tr>
  </tbody>
</table>


