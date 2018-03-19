package annex;

import xsbti.Logger;
import xsbti.compile.ClasspathOptionsUtil;
import xsbti.compile.CompileResult;
import xsbti.compile.Compilers;
import xsbti.compile.CompileOptions;
import xsbti.compile.IncrementalCompiler;
import xsbti.compile.Inputs;
import xsbti.compile.PreviousResult;
import xsbti.compile.ScalaInstance;
import xsbti.compile.Setup;

import sbt.internal.inc.IncrementalCompilerImpl;
import sbt.internal.inc.ZincUtil;

import java.io.File;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Arrays;
import java.util.function.Supplier;

final public class ZincRunner {
    public static void main(String args[]) {

        IncrementalCompilerImpl compiler = new IncrementalCompilerImpl();
        Logger logger = new ZincRunnerLogger();

        ScalaInstance scalaInstance = new ZincRunnerScalaInstance(
            null, null, null, null
        );
        File compilerBridgeJar = null;

        Compilers compilers = ZincUtil.compilers(
            scalaInstance,
            ClasspathOptionsUtil.boot(),
            scala.Option.apply(null),
            ZincUtil.scalaCompiler(scalaInstance, compilerBridgeJar)
        );

        CompileOptions compileOptions = CompileOptions.create();
        PreviousResult previousResult = PreviousResult.of(null, null);

        //xsbti.compile.PerClasspathEntryLookup _perClasspathEntryLookup, boolean _skip, java.io.File _cacheFile, xsbti.compile.GlobalsCache _cache, xsbti.compile.IncOptions _incrementalCompilerOptions, xsbti.Reporter _reporter, java.util.Optional<xsbti.compile.CompileProgress> _progress, xsbti.T2<String, String>[] _extra

        Setup setup = Setup.of(
            null,
            true,
            null,
            null,
            null,
            null,
            null,
            null
        );

        Inputs inputs = Inputs.of(
            compilers,
            compileOptions,
            setup,
            previousResult
        );

        CompileResult result = compiler.compile(inputs, logger);
    }
}

final class Lazy<T> {
    private volatile T value;
    public T getOrCompute(Supplier<T> supplier) {
        final T result = value; // Just one volatile read
        return result == null ? maybeCompute(supplier) : result;
    }
    private synchronized T maybeCompute(Supplier<T> supplier) {
        if (value == null)
            value = supplier.get();
        return value;
    }
}

final class ZincRunnerScalaInstance implements ScalaInstance {

    private final String version;
    private final Lazy<String> actualVersion = new Lazy<>();
    private final Lazy<ClassLoader> loader = new Lazy<>();
    private final File libraryJar;
    private final File compilerJar;
    private final File[] otherJars;
    private final File[] allJars;

    public ZincRunnerScalaInstance(
        String version,
        File libraryJar,
        File compilerJar,
        File[] otherJars
        ) {

        this.version = version;
        this.libraryJar = libraryJar;
        this.compilerJar = compilerJar;
        this.otherJars = otherJars;

        int length = otherJars.length;
        File[] allJars = Arrays.copyOf(otherJars, length + 2);
        allJars[length] = libraryJar;
        allJars[length + 1] = compilerJar;

        this.allJars = allJars;
    }

    public String version() {
        return this.version;
    }

    public String actualVersion() {
        return this.actualVersion.getOrCompute(() -> null);
    }

    public ClassLoader loader() {
        /*
        try {
        return this.loader.getOrCompute(() ->
        new URLClassLoader(Arrays.stream(this.allJars)
        .map(file -> file.toURI().toURL())
        .toArray(URL[]::new))
        );
        } catch (
        */
        return null;
    }

    public File libraryJar() {
        return this.libraryJar;
    }

    public File compilerJar() {
        return this.compilerJar;
    }

    public File[] otherJars() {
        return this.otherJars;
    }

    public File[] allJars() {
        return this.allJars;
    }
}

final class ZincRunnerLogger implements Logger {

    public void error(Supplier<String> msg) {
        System.out.println("[error]: " + msg.get());
    }

    public void warn(Supplier<String> msg) {
        System.out.println("[warn ]: " + msg.get());
    }

    public void info(Supplier<String> msg) {
        System.out.println("[info ]: " + msg.get());
    }

    public void debug(Supplier<String> msg) {
        System.out.println("[debug]: " + msg.get());
    }

    public void trace(Supplier<Throwable> exception) {
        System.out.println("[trace]: " + exception.get().getMessage());
    }

}
