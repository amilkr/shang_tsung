defmodule ShangTsung.ExecutionController do
  use ShangTsung.Web, :controller

  alias ShangTsung.Execution

  def index(conn, _params) do
    {:ok, configs} = {:ok, []} #File.ls(@config_dir)
    render conn, "index.html", configs: configs
  end

  def start(conn, params) do
    :ok = Execution.start(params["config"])
    render conn, "index.html", configs: []
  end
end
