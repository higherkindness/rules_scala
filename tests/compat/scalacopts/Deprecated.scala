package tests.compat.scalacopts

@deprecated("deprecated", "the dawn of time")
class Deprecated {
}

class App {
  new Deprecated
}
