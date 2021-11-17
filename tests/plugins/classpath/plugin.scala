package plug.it.in

import scala.tools.nsc.Global
import scala.tools.nsc.Phase
import scala.tools.nsc.plugins.{ Plugin => NscPlugin }
import scala.tools.nsc.plugins.{ PluginComponent => NscPluginComponent }

final class Plugin(override val global: Global) extends NscPlugin {
  override val name: String = Lib.name
  override val description: String = Lib.description
  override val components: List[NscPluginComponent] =
    PluginComponent :: Nil

  private object PluginComponent extends NscPluginComponent {
    override val global: Global = Plugin.this.global
    override val phaseName: String = "dummy-phase"
    override val runsAfter: List[String] = "parser" :: Nil

    override def newPhase(prev: Phase): Phase =
      new StdPhase(prev) {
        val global = Plugin.this.global
        def apply(unit: PluginComponent.global.CompilationUnit): Unit = {
          println("scalac plugin phase success")
        }
      }
  }
}
