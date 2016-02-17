defmodule PlayChannel.ToyControllerTest do
  use PlayChannel.ConnCase

  alias PlayChannel.Toy
  @valid_attrs %{age: 42, color: "some content", name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, toy_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing toys"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, toy_path(conn, :new)
    assert html_response(conn, 200) =~ "New toy"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, toy_path(conn, :create), toy: @valid_attrs
    assert redirected_to(conn) == toy_path(conn, :index)
    assert Repo.get_by(Toy, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, toy_path(conn, :create), toy: @invalid_attrs
    assert html_response(conn, 200) =~ "New toy"
  end

  test "shows chosen resource", %{conn: conn} do
    toy = Repo.insert! %Toy{}
    conn = get conn, toy_path(conn, :show, toy)
    assert html_response(conn, 200) =~ "Show toy"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, toy_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    toy = Repo.insert! %Toy{}
    conn = get conn, toy_path(conn, :edit, toy)
    assert html_response(conn, 200) =~ "Edit toy"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    toy = Repo.insert! %Toy{}
    conn = put conn, toy_path(conn, :update, toy), toy: @valid_attrs
    assert redirected_to(conn) == toy_path(conn, :show, toy)
    assert Repo.get_by(Toy, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    toy = Repo.insert! %Toy{}
    conn = put conn, toy_path(conn, :update, toy), toy: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit toy"
  end

  test "deletes chosen resource", %{conn: conn} do
    toy = Repo.insert! %Toy{}
    conn = delete conn, toy_path(conn, :delete, toy)
    assert redirected_to(conn) == toy_path(conn, :index)
    refute Repo.get(Toy, toy.id)
  end
end
