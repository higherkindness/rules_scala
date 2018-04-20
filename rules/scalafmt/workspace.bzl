load("//rules/scalafmt/3rdparty:maven.bzl", "maven_dependencies")

def annex_scalafmt_repositories():
    maven_dependencies()

def scalafmt_default_config(path = ".scalafmt.conf"):
    build = []
    build.append("filegroup(")
    build.append("    name = \"config\",")
    build.append("    srcs = [\"{}\"],".format(path))
    build.append("    visibility = [\"//visibility:public\"],")
    build.append(")")
    native.new_local_repository(name = "scalafmt_default", build_file_content = "\n".join(build), path = "")
