defmodule ShangTsung.Monitor do
  use GenServer

  def tsung_running? do
    case :global.whereis_name(:ts_mon) do
      pid when is_pid(pid) -> true
      :undefined -> false
    end
  end

  def fetch_stats do
    GenServer.cast(__MODULE__, :start_fetching_stats)
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast(:start_fetching_stats, state) do
    IO.inspect "start_fetching_stats..."
    case tsung_running?() do
      true ->
        schedule_fetch_stats(0)

      false ->
        Process.sleep(500)
        handle_cast(:start_fetching_stats, state)
    end
    {:noreply, state}
  end

  @impl true
  def handle_info(:fetch_stats, state) do
    IO.inspect "fetching..."

    case :ts_client_sup.active_clients() do
      0 ->
        IO.inspect "tsung has finished. stop fetching"

      _ ->
        stats = do_fetch_stats()
        IO.inspect stats
        :ok = schedule_fetch_stats()
    end

    {:noreply, state}
  end

  ### Internal Functions

  defp do_fetch_stats do
    {:ok, nodes, ended_beams, max_phases} = :ts_config_server.status()
    {clients, req_rate, connected, interval, phase, cpu} = :ts_mon.status()
    n_phase =
      case phase do
         :error -> 1;
         {:ok, n} -> div(n, nodes) + 1
      end

    %{
      phase: n_phase,
      phase_total: max_phases,
      users: clients,
      connected_users: connected,
      request_rate: req_rate / interval,
      active_beams: nodes - ended_beams,
      cpu_controller: cpu
    }
  end

  defp schedule_fetch_stats(time \\ 1_000) do
    _ref = Process.send_after(self(), :fetch_stats, time)
    :ok
  end
end