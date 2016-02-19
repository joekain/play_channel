defmodule PlayChannel.ToyChannelTest do
  use PlayChannel.ChannelCase

  alias PlayChannel.ToyChannel
  alias PlayChannel.Toy

  @valid_toy %{age: 42, color: "some content", name: "some content"}
  setup do
    toy = Toy.changeset(%Toy{}, @valid_toy)
    |> Repo.insert!

    {:ok, payload, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(ToyChannel, "toys:#{toy.id}")

    {:ok, socket: socket, payload: payload, toy: toy}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end

  test "join delivers the original model", %{payload: payload, toy: toy} do
    assert payload == %{"age" => 42, "color" => "some content",
                        "name" => "some content", "id" => toy.id}
  end

  test "broadcast_change tiggers a broadcast", %{toy: toy} do
    Toy.changeset(toy, %{age: 3})
    |> Repo.update!
    |> ToyChannel.broadcast_change

    assert_broadcast "change", _
  end
end
