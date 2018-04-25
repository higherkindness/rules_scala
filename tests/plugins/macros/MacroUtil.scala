import scala.collection.mutable.ListBuffer
import scala.reflect.macros.Context

object MacroUtil {
  def precompute(c: Context)(evals: ListBuffer[c.universe.ValDef], value: c.universe.Tree, tpe: c.universe.Type): c.universe.Ident = {
    import c.universe._
    val freshName = TermName(c.fresh("eval$"))
    evals += ValDef(Modifiers(), freshName, TypeTree(tpe), value)
    Ident(freshName)
  }
}
