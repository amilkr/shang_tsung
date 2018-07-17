defmodule ShangTsung.Execution do
  def start(config_name) do
    :ok = cleanup()
    :ok = update_tsung_env(config_name)
    Application.unload(:tsung)
    :tsung_controller.start()
  end

  ## TODO
  def stop do
    :ok
  end

  ### Internal Functions

  defp cleanup do
    _ = :error_logger.logfile(:close)
    _ = Application.stop(:tsung_controller)
    _ = Application.stop(:tsung)
    :ok
  end

  defp update_tsung_env(config_name) do
    [
      log_dir:      log_dir(config_name),
      config_file:  config_file(config_name),
      keep_web_gui: true
    ]
    |> Enum.each(fn({k, v}) ->
      Application.put_env(:tsung_controller, k, v, [persistent: true])
    end)
  end

  defp config_file(config_name) do
    Application.get_env(:shang_tsung, :tsung_config_dir) <> config_name
    |> String.to_charlist
  end

  defp log_dir(config_name) do
    log_dir =
      Application.get_env(:shang_tsung, :tsung_log_dir) <> config_name <> "/"
      |> String.to_charlist

    :ok = File.mkdir_p(log_dir)
    log_dir
  end
end
