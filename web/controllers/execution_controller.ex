defmodule ShangTsung.ExecutionController do
  use ShangTsung.Web, :controller

  alias ShangTsung.Execution

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(conn, params) do
    config_dir = Application.get_env(:shang_tsung, :tsung_config_dir)
    config_file = params["execution"]["config_file"]
    {:ok, content} = File.read(config_file.path)
    :ok = File.write!(config_dir <> config_file.filename, content)
    :ok = Execution.start(config_file.filename)
    render(conn, "index.html")
  end

  def delete(conn, _params) do
    :ok = Execution.stop
    render(conn, "index.html")
  end
end
