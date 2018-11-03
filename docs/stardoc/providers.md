<a name="#declare_scala_configuration"></a>
## declare_scala_configuration

<pre>
declare_scala_configuration(name, compiler_classpath, runtime_classpath, version)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#declare_scala_configuration_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#declare_scala_configuration_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#declare_scala_configuration_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
    <tr id="#declare_scala_configuration_version">
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
declare_zinc_configuration(name, compiler_bridge)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#declare_zinc_configuration_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#declare_zinc_configuration_compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        Label; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#join_configurations"></a>
## join_configurations

<pre>
join_configurations(name, configurations)
</pre>



### Attributes

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#join_configurations_name">
      <td><code>name</code></td>
      <td>
        String; required
        <p>
          A unique name for this target.
        </p>
      </td>
    </tr>
    <tr id="#join_configurations_configurations">
      <td><code>configurations</code></td>
      <td>
        List of labels; required
      </td>
    </tr>
  </tbody>
</table>


<a name="#ScalaConfiguration"></a>
## ScalaConfiguration

Provides access to the Scala compiler jars

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#ScalaConfiguration_version">
      <td><code>version</code></td>
      <td>
        <p>the Scala full version</p>
      </td>
    </tr>
    <tr id="#ScalaConfiguration_compiler_classpath">
      <td><code>compiler_classpath</code></td>
      <td>
        <p>the compiler classpath</p>
      </td>
    </tr>
    <tr id="#ScalaConfiguration_runtime_classpath">
      <td><code>runtime_classpath</code></td>
      <td>
        <p>the minimal runtime classpath</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ScalaInfo"></a>
## ScalaInfo

Provider for cross versioned scala rule outputs

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#ScalaInfo_macro">
      <td><code>macro</code></td>
      <td>
        <p>whether the jar contains macros</p>
      </td>
    </tr>
    <tr id="#ScalaInfo_scala_configuration">
      <td><code>scala_configuration</code></td>
      <td>
        <p>the scala configuration associated with this output</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ZincConfiguration"></a>
## ZincConfiguration

Provides additional items needed by Zinc

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#ZincConfiguration_compiler_bridge">
      <td><code>compiler_bridge</code></td>
      <td>
        <p>the compiled Zinc compiler bridge</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#ZincInfo"></a>
## ZincInfo

Provides additional outputs from Zinc

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#ZincInfo_apis">
      <td><code>apis</code></td>
      <td>
        <p>API file</p>
      </td>
    </tr>
    <tr id="#ZincInfo_deps">
      <td><code>deps</code></td>
      <td>
        <p>Depset</p>
      </td>
    </tr>
    <tr id="#ZincInfo_deps_files">
      <td><code>deps_files</code></td>
      <td>
        <p>Depset of all files</p>
      </td>
    </tr>
    <tr id="#ZincInfo_label">
      <td><code>label</code></td>
      <td>
        <p>Label</p>
      </td>
    </tr>
    <tr id="#ZincInfo_relations">
      <td><code>relations</code></td>
      <td>
        <p>Relations file</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#IntellijInfo"></a>
## IntellijInfo

Provider for IntelliJ

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#IntellijInfo_outputs">
      <td><code>outputs</code></td>
      <td>
        <p>java_output_jars</p>
      </td>
    </tr>
    <tr id="#IntellijInfo_transitive_exports">
      <td><code>transitive_exports</code></td>
      <td>
        <p>labels of transitive dependencies</p>
      </td>
    </tr>
  </tbody>
</table>


<a name="#LabeledJars"></a>
## LabeledJars

Exported jars and their labels

### Fields

<table class="params-table">
  <colgroup>
    <col class="col-param" />
    <col class="col-description" />
  </colgroup>
  <tbody>
    <tr id="#LabeledJars_values">
      <td><code>values</code></td>
      <td>
        <p>Preorder depset of label and jars</p>
      </td>
    </tr>
  </tbody>
</table>


