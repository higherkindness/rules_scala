package annex

import sbt.testing.Logger

class PrefixedLogger(delegate: Logger, prefix: String) extends Logger {
  def ansiCodesSupported() = delegate.ansiCodesSupported()
  def error(msg: String) = delegate.error(prefix + msg)
  def warn(msg: String) = delegate.warn(prefix + msg)
  def info(msg: String) = delegate.info(prefix + msg)
  def debug(msg: String) = delegate.debug(prefix + msg)
  def trace(t: Throwable) = delegate.trace(t)
}
