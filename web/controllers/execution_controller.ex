defmodule ShangTsung.ExecutionController do
  use ShangTsung.Web, :controller

  plug :action

  @config_dir Application.get_env(:shang_tsung, :tsung_config_dir)
  @log_dir Application.get_env(:shang_tsung, :tsung_log_dir)

  def index(conn, _params) do
    # open a channel to get and display tsung logs
    {:ok, configs} = File.ls(@config_dir)
    render conn, "index.html", configs: configs
  end

  def start(conn, params) do
    # ShangTsung.Endpoint.broadcast!("logs:tsung", "new_line", %{line: "Starting"})
    # :ok = File.write(@console_output, "")
    # # Task.async(System, :cmd, ["tsung", ["-f", "config/tsung/default.xml", "-l", @log_dir, "start", ">", @console_output]])
    # Task.async(:os, :cmd, ['tsung -f config/tsung/default.xml -l ' ++ @log_dir ++ ' start > ' ++ @console_output])
    # ["Starting Tsung\n", "\"Log directory is: " <> log_file] = File.stream!(to_string(@console_output)) |> Enum.take(2)
    # String.split(log_file, "\"\n")
    {:ok, configs} = File.ls(@config_dir)
    render conn, "index.html", tsung_configs: configs
  end
  
end
