defmodule ShangTsung.Monitor do
  require Logger

  alias ShangTsung.Monitor

  def start(tsung_node) do
    interval = Application.get_env(:tsung_controller, :dumpstats_interval)
    Task.Supervisor.start_child(:monitor_sup, Monitor, :loop, [tsung_node, interval])
  end

  def stop() do
    Task.Supervisor.children(:monitor_sup)
    |> Enum.each fn(pid) ->
      Task.Supervisor.terminate_child(:monitor_sup, pid)
    end
  end

  def loop(tsung_node, interval) do
    Logger.debug "loop #{interval}"
    Process.send_after(self, :interval, interval)
    process_status(tsung_node)
    :ok = wait_interval()
    loop(tsung_node, interval)
  end

  def wait_interval() do
    receive do
      :interval ->
        :ok
    end
  end

  def process_status(tsung_node) do
    # TODO
    # read tsung stats
    # parse stats
    # send through channel
  end
  
end
