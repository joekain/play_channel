defmodule PlayChannel.ToyChannelTest do
  use PlayChannel.ChannelCase

  alias PlayChannel.ToyChannel
  alias PlayChannel.Toy

  setup do
    toy = Toy.changeset(%Toy{}, %{age: 42, color: "some content", name: "some content"})
    |> Repo.insert!

    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(ToyChannel, "toys:#{toy.id}")

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
