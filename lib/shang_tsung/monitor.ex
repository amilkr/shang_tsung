defmodule ShangTsung.Monitor do
  require Logger

  alias ShangTsung.Monitor
  alias ShangTsung.ExecutionSocket

  def start do
    :ok = wait_ts_mon()
    interval = Application.get_env(:tsung_controller, :dumpstats_interval)
    Task.Supervisor.start_child(:monitor_sup, Monitor, :loop, [interval])
  end

  def stop do
    Task.Supervisor.children(:monitor_sup)
    |> Enum.each fn(pid) ->
      Task.Supervisor.terminate_child(:monitor_sup, pid)
    end
  end

  def loop(interval) do
    Process.send_after(self, :interval, interval)
    get_status
    |> send_status
    :ok = wait_interval()
    loop(interval)
  end

  defp get_status do
    {_clients, count, tcp_count, interval, _phase} = :ts_mon.status
    rps = fround(count/interval)
    Map.merge(%{reqs_per_sec: rps, tcp_count: tcp_count}, get_req_status())
  end

  defp get_req_status do
    {:state, _pid, _backend, _dump_interval,
     :request, _fullstats, _interval_stats, laststats} = :sys.get_state({:global, :request})
    [_, _, max, min, _, mean, _total, _] = laststats
    %{req_max: fround(max), req_min: fround(min), req_mean: fround(mean)}
  end

  defp send_status(status) do
    ExecutionSocket.notify(:status_update, status)
  end

  defp wait_ts_mon do
    case :global.whereis_name(:ts_mon) do
      :undefined ->
        :timer.sleep(100)
        wait_ts_mon()
      pid when is_pid(pid) ->
        :ok
    end
  end

  defp wait_interval() do
    receive do
      :interval ->
        :ok
    end
  end

  defp fround(n) do
    Float.round(1.0 * n, 2)
  end
end
