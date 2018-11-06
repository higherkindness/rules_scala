<a name="#scalac_library"></a>
## scalac_library

<pre>
scalac_library(name, deps, macro, runtime_deps, scala, srcs)
</pre>


Compiles a Scala JVM library.

This is a low-level rule used to bootstrap higher-level rules.
You probably don't want to use this directly.


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scalac_library_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scalac_library_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scalac_library_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#scalac_library_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scalac_library_scala">
      <td><code>scala</code></td>
      <td>
        Label; required
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#scalac_library_srcs">
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


<a name="#scalac_binary"></a>
## scalac_binary

<pre>
scalac_binary(name, deps, macro, main_class, runtime_deps, scala, srcs)
</pre>


Compiles and link a Scala JVM executable.

This is a low-level rule used to bootstrap higher-level rules.
You probably don't want to use this directly.


### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#scalac_binary_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#scalac_binary_deps">
      <td><code>deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scalac_binary_macro">
      <td><code>macro</code></td>
      <td>
        Boolean; optional
        <p>
          Whether this library provides macros.
        </p>
      </td>
    </tr>
    <tr id="#scalac_binary_main_class">
      <td><code>main_class</code></td>
      <td>
        String; required
        <p>
          The main class.
        </p>
      </td>
    </tr>
    <tr id="#scalac_binary_runtime_deps">
      <td><code>runtime_deps</code></td>
      <td>
        List of labels; optional
        <p>
          The JVM runtime-only library dependencies.
        </p>
      </td>
    </tr>
    <tr id="#scalac_binary_scala">
      <td><code>scala</code></td>
      <td>
        Label; required
        <p>
          The `ScalaConfiguration`.
        </p>
      </td>
    </tr>
    <tr id="#scalac_binary_srcs">
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
<unknown name>(name, compiler_classpath, runtime_classpath, version)
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
        <p>
          The compiler classpath.
        </p>
      </td>
    </tr>
    <tr id="#<unknown name>_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
        <p>
          The runtime classpath.
        </p>
      </td>
    </tr>
    <tr id="#<unknown name>_version">
      <td><code>version</code></td>
      <td>
        String; required
        <p>
          The Scala full version.
        </p>
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
  </tbody>
</table>


