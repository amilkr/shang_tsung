defmodule ShangTsung.Execution do
  alias ShangTsung.Execution
  alias ShangTsung.Monitor

  def start(config_name) do
    config_name
    |> tsung_env
    |> launch_tsung
    Monitor.start()
  end

  def stop do
    :ok = Monitor.stop()
    :slave.stop(tsung_node())
  end

  defp tsung_env(config_name) do
    [{:config_file, config_file(config_name)},
     {:log_dir, log_dir(config_name)}
     | Application.get_all_env(:tsung_controller)]
  end

  defp launch_tsung(env) do
    :ok = ensure_tsung_node()
    :ok = :rpc.call(tsung_node(), Execution, :set_env, [env])
    true = :rpc.cast(tsung_node(), :tsung_controller, :start, [])
    :ok
  end

  defp ensure_tsung_node do
    args = " -pa " <> (:code.get_path() |> Enum.join(" -pa ")) |> String.to_charlist
    {:ok, node} = Application.get_env(:shang_tsung, :tsung_node_host)
    |> String.to_atom
    |> :slave.start(:"tsung-controller", args)
    ^node = tsung_node()
    :ok
  end

  defp tsung_node do
    "tsung-controller@" <> Application.get_env(:shang_tsung, :tsung_node_host)
    |> String.to_atom
  end

  def set_env(env) do
    Enum.each(env, fn({k, v}) ->
      Application.put_env(:tsung_controller, k, v, persistent: true)
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
