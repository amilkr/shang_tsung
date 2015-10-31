defmodule ShangTsung.Execution do
  alias ShangTsung.Execution
  alias ShangTsung.Monitor

  def start(config_name) do
    :ok = launch_tsung(config_file(config_name), log_dir(config_name))
    Monitor.start(tsung_node())
  end

  defp launch_tsung(config_file, log_dir) do
    :ok = ensure_tsung_node()
    :ok = :rpc.call(tsung_node(), Execution, :set_env, [config_file, log_dir])
    true = :rpc.cast(tsung_node(), :tsung_controller, :start, [])
  end

  defp ensure_tsung_node do
    args = " -pa " <> (:code.get_path() |> Enum.join(" -pa ")) |> String.to_char_list
    {:ok, node} =
      Application.get_env(:shang_tsung, :tsung_node_host)
      |> String.to_atom
      |> :slave.start(:"tsung-controller", args)
    ^node = tsung_node()
    :ok
  end

  defp tsung_node do
    "tsung-controller@" <> Application.get_env(:shang_tsung, :tsung_node_host)
    |> String.to_atom
  end

  def set_env(config_file, log_dir) do
    [config_file: config_file,
     log_dir: log_dir,
     mon_file: 'mon.log',
     match_log_file: 'match.log',
     log_file: 'tsung.log']
    |> Enum.each fn({k, v}) ->
      Application.put_env(:tsung_controller, k, v, persistent: true)
    end
  end

  defp config_file(config_name) do
    Application.get_env(:shang_tsung, :tsung_config_dir) <> config_name
    |> String.to_char_list
  end

  defp log_dir(config_name) do
    log_dir = Application.get_env(:shang_tsung, :tsung_log_dir) <> config_name <> "/"
              |> String.to_char_list
    :ok = log_dir |> File.mkdir_p
    log_dir
  end 
end