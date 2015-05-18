defmodule ShangTsung.RunController do
  use ShangTsung.Web, :controller

  plug :action

  @console_output 'log/tsung/runs/console_output.txt'
  @log_dir 'log/tsung/runs/'

  def index(conn, _params) do
    # open a channel to get and display tsung logs
    render conn, "index.html"
  end

  def init(conn, _params) do
    # create a new run entity

    ShangTsung.Endpoint.broadcast!("logs:tsung", "new_line", %{line: "Starting"})
    :ok = File.write(@console_output, "")
    # Task.async(System, :cmd, ["tsung", ["-f", "config/tsung/default.xml", "-l", @log_dir, "start", ">", @console_output]])
    Task.async(:os, :cmd, ['tsung -f config/tsung/default.xml -l ' ++ @log_dir ++ ' start > ' ++ @console_output])
    ["Starting Tsung\n", "\"Log directory is: " <> log_file] = File.stream!(to_string(@console_output)) |> Enum.take(2)
    String.split(log_file, "\"\n")
    render conn, "index.html"
  end
  
end
