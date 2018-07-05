defmodule ShangTsung.Execution do
  alias ShangTsung.Monitor

  def start(config_name) do
    :ok = launch_tsung(config_name)
    Monitor.start()
  end

  def stop do
    :ok = Monitor.stop()
    :slave.stop(tsung_node())
  end

  defp launch_tsung(config_name) do
    {:ok, tnode} = ensure_tsung_node()
    :ok = set_tsung_env(tnode, config_name)
    :rpc.call(tnode, :tsung_controller, :start, [])
  end

  defp ensure_tsung_node do
    args = " -pa " <> (:code.get_path() |> Enum.join(" -pa ")) |> String.to_charlist

    Application.get_env(:shang_tsung, :tsung_node_host)
    |> String.to_atom
    |> :slave.start(:"tsung-controller", args)
  end

  defp tsung_node do
    "tsung-controller@" <> Application.get_env(:shang_tsung, :tsung_node_host)
    |> String.to_atom
  end

  def set_tsung_env(tnode, config_name) do
    Application.get_all_env(:tsung_controller) |> Keyword.put(:config_file, config_file(config_name)) |> Keyword.put(:log_dir, log_dir(config_name))
    |> Enum.each(fn({k, v}) ->
      :ok = :rpc.call(tnode, Application, :put_env, [:tsung_controller, k, v, [persistent: true]])
    end)
  end

  defp config_file(config_name) do
    Application.get_env(:shang_tsung, :tsung_config_dir) <> config_name
    |> String.to_charlist
  end

  defp log_dir(config_name) do
    log_dir = Application.get_env(:shang_tsung, :tsung_log_dir) <> config_name <> "/"
    |> String.to_charlist
    :ok = File.mkdir_p(log_dir)
    log_dir
  end
end
