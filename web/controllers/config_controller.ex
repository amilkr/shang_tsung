defmodule ShangTsung.ConfigController do
  use ShangTsung.Web, :controller

  # @config_dir Application.get_env(:shang_tsung, :tsung_config_dir)

  def new(conn, params) do
    # file = params["config"]["file"]
    # {:ok, content} = File.read(file.path)
    # :ok = File.write!(@config_dir <> file.filename, content)
    render conn, "new.html"
  end
end