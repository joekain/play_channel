defmodule PlayChannel.ToyController do
  use PlayChannel.Web, :controller

  alias PlayChannel.Toy

  plug :scrub_params, "toy" when action in [:create, :update]

  def index(conn, _params) do
    toys = Repo.all(Toy)
    render(conn, "index.html", toys: toys)
  end

  def new(conn, _params) do
    changeset = Toy.changeset(%Toy{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"toy" => toy_params}) do
    changeset = Toy.changeset(%Toy{}, toy_params)

    case Repo.insert(changeset) do
      {:ok, _toy} ->
        conn
        |> put_flash(:info, "Toy created successfully.")
        |> redirect(to: toy_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    toy = Repo.get!(Toy, id)
    render(conn, "show.html", toy: toy)
  end

  def edit(conn, %{"id" => id}) do
    toy = Repo.get!(Toy, id)
    changeset = Toy.changeset(toy)
    render(conn, "edit.html", toy: toy, changeset: changeset)
  end

  def update(conn, %{"id" => id, "toy" => toy_params}) do
    toy = Repo.get!(Toy, id)
    changeset = Toy.changeset(toy, toy_params)

    case Repo.update(changeset) do
      {:ok, toy} ->
        GenEvent.notify(:toy_event_manager, {:update, toy})

        conn
        |> put_flash(:info, "Toy updated successfully.")
        |> redirect(to: toy_path(conn, :show, toy))
      {:error, changeset} ->
        render(conn, "edit.html", toy: toy, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    toy = Repo.get!(Toy, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(toy)

    conn
    |> put_flash(:info, "Toy deleted successfully.")
    |> redirect(to: toy_path(conn, :index))
  end
end
