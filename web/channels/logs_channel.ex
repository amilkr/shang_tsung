defmodule ShangTsung.LogsChannel do
  use Phoenix.Channel

  def join("logs:tsung", _auth_msg, socket) do
    {:ok, socket}
  end

  def handle_in("new_line", payload, socket) do
    broadcast! socket, "new_line", payload
    {:noreply, socket}
  end

end