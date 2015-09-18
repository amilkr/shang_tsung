defmodule ShangTsung.ExecutionController do
  use ShangTsung.Web, :controller

  alias ShangTsung.TsungExecution

  # @config_dir Application.get_env(:shang_tsung, :tsung_config_dir)
  # @log_parent_dir Application.get_env(:shang_tsung, :tsung_log_dir)

  def index(conn, _params) do
    {:ok, configs} = {:ok, []} #File.ls(@config_dir)
    render conn, "index.html", configs: configs
  end

  def start(conn, params) do
    # config_file = @config_dir <> params["config"] |> String.to_char_list
    # log_dir = @log_parent_dir <> params["config"] <> "/"  |> String.to_char_list
    # :ok = TsungExecution.start(config_file, log_dir)
    # ShangTsung.Endpoint.broadcast!("tsung:status", "running", %{})
    # {:ok, configs} = File.ls(@config_dir)
    render conn, "index.html", configs: []
  end
end
