defmodule PlayChannel.ToyChannel do
  use PlayChannel.Web, :channel

  def join("toys:" <> toy_id, payload, socket) do
    {:ok, "Joined toys:#{toy_id}", socket}
  end

  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end
end
