defmodule Mix.Tasks.Tsung do
  defmodule Install do
    use Mix.Task

    def run(_) do
      source = "http://tsung.erlang-projects.org/dist/tsung-1.5.1.tar.gz"

      Mix.shell.cmd("wget #{source}")
      Mix.shell.cmd("tar -zxf tsung-1.5.1.tar.gz")
      Mix.shell.cmd("cd tsung-1.5.1/; ./configure")
      Mix.shell.cmd("cd tsung-1.5.1/; make")
      Mix.shell.cmd("cd tsung-1.5.1/; make install")
      Mix.shell.cmd("rm -rf tsung-1.5.1*")
      Mix.shell.info "done"
    end
  end
end