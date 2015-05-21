defmodule ShangTsung.TsungExecution do
  alias ShangTsung.TsungExecution

  def start(config_file, log_dir) do
    :ok = log_dir |> File.mkdir_p
    :ok = ensure_tsung_node()
    :ok = :rpc.call(tsung_node(), TsungExecution, :set_env, [config_file, log_dir])
    true = :rpc.cast(tsung_node(), :tsung_controller, :start, [])
    :ok
  end
  
  defp ensure_tsung_node do
    args = " -pa " <> (:code.get_path() |> Enum.join(" -pa ")) |> String.to_char_list
    {:ok, node} =
      Application.get_env(:shang_tsung, :tsung_node_host)
      |> String.to_atom
      |> :slave.start(:"tsung-01", args)
    ^node = tsung_node()
    :ok
  end

  defp tsung_node do
    "tsung-01@" <> Application.get_env(:shang_tsung, :tsung_node_host)
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
end