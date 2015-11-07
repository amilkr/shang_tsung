defmodule ShangTsung.ExecutionChannel do
  use Phoenix.Channel

  def join("execution:status", _message, socket) do
    {:ok, socket}
  end

  def handle_in("update", status, socket) do
    broadcast! socket, "update", status
    {:noreply, socket}
  end
  
end