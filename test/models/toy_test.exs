defmodule PlayChannel.ToyTest do
  use PlayChannel.ModelCase

  alias PlayChannel.Toy

  @valid_attrs %{age: 42, color: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Toy.changeset(%Toy{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Toy.changeset(%Toy{}, @invalid_attrs)
    refute changeset.valid?
  end
end
