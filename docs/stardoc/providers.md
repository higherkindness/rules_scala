<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#declare_scala_configuration"></a>

## declare_scala_configuration

<pre>
declare_scala_configuration(<a href="#declare_scala_configuration-name">name</a>, <a href="#declare_scala_configuration-compiler_classpath">compiler_classpath</a>, <a href="#declare_scala_configuration-global_plugins">global_plugins</a>, <a href="#declare_scala_configuration-global_scalacopts">global_scalacopts</a>, <a href="#declare_scala_configuration-runtime_classpath">runtime_classpath</a>, <a href="#declare_scala_configuration-version">version</a>)
</pre>

Creates a `ScalaConfiguration`.

### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="declare_scala_configuration-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="declare_scala_configuration-compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; required
      </td>
    </tr>
    <tr id="declare_scala_configuration-global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; optional
        <p>
          Scalac plugins that will always be enabled.
        </p>
      </td>
    </tr>
    <tr id="declare_scala_configuration-global_scalacopts">
      <td><code>global_scalacopts</code></td>
      <td>
        List of strings; optional
        <p>
          Scalac options that will always be enabled.
        </p>
      </td>
    </tr>
    <tr id="declare_scala_configuration-runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; required
      </td>
    </tr>
    <tr id="declare_scala_configuration-version">
      <td><code>version</code></td>
      <td>
        String; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#declare_zinc_configuration"></a>

## declare_zinc_configuration

<pre>
declare_zinc_configuration(<a href="#declare_zinc_configuration-name">name</a>, <a href="#declare_zinc_configuration-compiler_bridge">compiler_bridge</a>)
</pre>

Creates a `ZincConfiguration`.

### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="declare_zinc_configuration-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="declare_zinc_configuration-compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#join_configurations"></a>

## join_configurations

<pre>
join_configurations(<a href="#join_configurations-name">name</a>, <a href="#join_configurations-configurations">configurations</a>)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="join_configurations-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="join_configurations-configurations">
      <td><code>configurations</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a>; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#reconfigure_deps_configuration"></a>

## reconfigure_deps_configuration

<pre>
reconfigure_deps_configuration(<a href="#reconfigure_deps_configuration-name">name</a>, <a href="#reconfigure_deps_configuration-direct">direct</a>, <a href="#reconfigure_deps_configuration-provider">provider</a>, <a href="#reconfigure_deps_configuration-used">used</a>)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="reconfigure_deps_configuration-name">
      <td><code>name</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#name">Name</a>; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="reconfigure_deps_configuration-direct">
      <td><code>direct</code></td>
      <td>
        String; optional
      </td>
    </tr>
    <tr id="reconfigure_deps_configuration-provider">
      <td><code>provider</code></td>
      <td>
        <a href="https://bazel.build/docs/build-ref.html#labels">Label</a>; required
      </td>
    </tr>
    <tr id="reconfigure_deps_configuration-used">
      <td><code>used</code></td>
      <td>
        String; optional
      </td>
    </tr>
  </tbody>
</table>


<a name="#CodeCoverageConfiguration"></a>

## CodeCoverageConfiguration

<pre>
CodeCoverageConfiguration(<a href="#CodeCoverageConfiguration-instrumentation_worker">instrumentation_worker</a>)
</pre>

Code coverage related configuration

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="CodeCoverageConfiguration-instrumentation_worker">
      <td><code>instrumentation_worker</code></td>
      <td>
        <p>the worker used for instrumenting jars</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#DepsConfiguration"></a>

## DepsConfiguration

<pre>
DepsConfiguration(<a href="#DepsConfiguration-direct">direct</a>, <a href="#DepsConfiguration-used">used</a>, <a href="#DepsConfiguration-worker">worker</a>)
</pre>

Dependency checking configuration.

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="DepsConfiguration-direct">
      <td><code>direct</code></td>
      <td>
        <p>either error or off</p>
      </td>
    </tr>
    <tr id="DepsConfiguration-used">
      <td><code>used</code></td>
      <td>
        <p>either error or off</p>
      </td>
    </tr>
    <tr id="DepsConfiguration-worker">
      <td><code>worker</code></td>
      <td>
        <p>the worker label for checking used/unused deps</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#IntellijInfo"></a>

## IntellijInfo

<pre>
IntellijInfo(<a href="#IntellijInfo-outputs">outputs</a>, <a href="#IntellijInfo-transitive_exports">transitive_exports</a>)
</pre>

Provider for IntelliJ.

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="IntellijInfo-outputs">
      <td><code>outputs</code></td>
      <td>
        <p>java_output_jars</p>
      </td>
    </tr>
    <tr id="IntellijInfo-transitive_exports">
      <td><code>transitive_exports</code></td>
      <td>
        <p>labels of transitive dependencies</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#LabeledJars"></a>

## LabeledJars

<pre>
LabeledJars(<a href="#LabeledJars-values">values</a>)
</pre>

Exported jars and their labels.

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="LabeledJars-values">
      <td><code>values</code></td>
      <td>
        <p>The preorder depset of label and jars.</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ScalaConfiguration"></a>

## ScalaConfiguration

<pre>
ScalaConfiguration(<a href="#ScalaConfiguration-version">version</a>, <a href="#ScalaConfiguration-compiler_classpath">compiler_classpath</a>, <a href="#ScalaConfiguration-runtime_classpath">runtime_classpath</a>, <a href="#ScalaConfiguration-global_plugins">global_plugins</a>, <a href="#ScalaConfiguration-global_scalacopts">global_scalacopts</a>)
</pre>

Scala compile-time and runtime configuration

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="ScalaConfiguration-version">
      <td><code>version</code></td>
      <td>
        <p>The Scala full version.</p>
      </td>
    </tr>
    <tr id="ScalaConfiguration-compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        <p>The compiler classpath.</p>
      </td>
    </tr>
    <tr id="ScalaConfiguration-runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        <p>The runtime classpath.</p>
      </td>
    </tr>
    <tr id="ScalaConfiguration-global_plugins">
      <td><code>global_plugins</code></td>
      <td>
        <p>Globally enabled compiler plugins</p>
      </td>
    </tr>
    <tr id="ScalaConfiguration-global_scalacopts">
      <td><code>global_scalacopts</code></td>
      <td>
        <p>Globally enabled compiler options</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ScalaInfo"></a>

## ScalaInfo

<pre>
ScalaInfo(<a href="#ScalaInfo-macro">macro</a>, <a href="#ScalaInfo-scala_configuration">scala_configuration</a>)
</pre>

Scala library.

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="ScalaInfo-macro">
      <td><code>macro</code></td>
      <td>
        <p>whether the jar contains macros</p>
      </td>
    </tr>
    <tr id="ScalaInfo-scala_configuration">
      <td><code>scala_configuration</code></td>
      <td>
        <p>ScalaConfiguration associated with this output</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ScalaRulePhase"></a>

## ScalaRulePhase

<pre>
ScalaRulePhase(<a href="#ScalaRulePhase-phases">phases</a>)
</pre>

A Scala compiler plugin

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="ScalaRulePhase-phases">
      <td><code>phases</code></td>
      <td>
        <p>the phases to add</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ZincConfiguration"></a>

## ZincConfiguration

<pre>
ZincConfiguration(<a href="#ZincConfiguration-compiler_bridge">compiler_bridge</a>, <a href="#ZincConfiguration-compile_worker">compile_worker</a>, <a href="#ZincConfiguration-log_level">log_level</a>)
</pre>

Zinc configuration.

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="ZincConfiguration-compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        <p>compiled Zinc compiler bridge</p>
      </td>
    </tr>
    <tr id="ZincConfiguration-compile_worker">
      <td><code>compile_worker</code></td>
      <td>
        <p>the worker label for compilation with Zinc</p>
      </td>
    </tr>
    <tr id="ZincConfiguration-log_level">
      <td><code>log_level</code></td>
      <td>
        <p>log level for the Zinc compiler</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ZincInfo"></a>

## ZincInfo

<pre>
ZincInfo(<a href="#ZincInfo-apis">apis</a>, <a href="#ZincInfo-deps">deps</a>, <a href="#ZincInfo-deps_files">deps_files</a>, <a href="#ZincInfo-label">label</a>, <a href="#ZincInfo-relations">relations</a>)
</pre>

Zinc-specific outputs.

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="ZincInfo-apis">
      <td><code>apis</code></td>
      <td>
        <p>The API file.</p>
      </td>
    </tr>
    <tr id="ZincInfo-deps">
      <td><code>deps</code></td>
      <td>
        <p>The depset of library dependency outputs.</p>
      </td>
    </tr>
    <tr id="ZincInfo-deps_files">
      <td><code>deps_files</code></td>
      <td>
        <p>The depset of all Zinc files.</p>
      </td>
    </tr>
    <tr id="ZincInfo-label">
      <td><code>label</code></td>
      <td>
        <p>The label for this output.</p>
      </td>
    </tr>
    <tr id="ZincInfo-relations">
      <td><code>relations</code></td>
      <td>
        <p>The relations file.</p>
      </td>
    </tr>
  </tbody>
</table>


