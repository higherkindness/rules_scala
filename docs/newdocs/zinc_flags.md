## Pass flags to Zinc compiler

### Persistence Directory Path
Use `--persistence_dir` to specify the path to save Zinc state files.

### Use Persistence Directory
Use `--use_persistence` to enable or disable the persistence directory. The default is `true`.

### Maximum Error Number
Use `--max_errors` to specify the number of errors to be shown from Zinc. The default is `10`.

## Example
In `.bazelrc` file, add the following snippet
```sh
build --worker_extra_flag=ScalaCompile=--persistence_dir=bazel-zinc
build --worker_extra_flag=ScalaCompile=--use_persistence=true
build --worker_extra_flag=ScalaCompile=--max_errors=20
```
