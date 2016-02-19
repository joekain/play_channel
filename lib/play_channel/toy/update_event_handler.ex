defmodule PlayChannel.Toy.UpdateEventHandler do
  use GenEvent

  def handle_event({:update, toy}, _) do
    PlayChannel.ToyChannel.broadcast_change(toy)
    {:ok, nil}
  end

  def register_with_manager do
    PlayChannel.Toy.EventManager.register(__MODULE__, nil)
  end
end
