import scala.reflect.runtime.universe

class Item(name: String)

object Reflect {

  def main(args: Array[String]): Unit = {
    val `type` = universe.typeOf[Item]
    val mirror = universe.runtimeMirror(getClass.getClassLoader)
    val classMirror = mirror.reflectClass(`type`.typeSymbol.asClass)
    val methodMirror = classMirror.reflectConstructor(`type`.decl(universe.termNames.CONSTRUCTOR).asMethod)
    methodMirror("example").asInstanceOf[Item]
  }

}
