defmodule ShangTsungWeb.ExecutionController do
  use ShangTsungWeb, :controller

  alias ShangTsung.Execution

  def index(conn, _params) do
    render_index(conn)
  end

  def create(conn, %{"execution" => %{"config_name" => config_name}}) do
    result = Execution.start(config_name)

    conn
    |> put_flash(:info, "start result #{result}")
    |> render_index()
  end

  def delete(conn, _params) do
    :ok = Execution.stop

    conn
    |> put_flash(:error, "The load has stopped")
    |> render_index()
  end

  ### Internal Functions

  defp render_index(conn) do
    render(conn, "index.html", config_names: config_names())
  end

  defp config_names() do
    Application.get_env(:shang_tsung, :tsung_config_dir)
    |> File.ls!
  end
end
