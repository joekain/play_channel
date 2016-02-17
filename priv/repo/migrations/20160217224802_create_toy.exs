defmodule PlayChannel.Repo.Migrations.CreateToy do
  use Ecto.Migration

  def change do
    create table(:toys) do
      add :name, :string
      add :color, :string
      add :age, :integer

      timestamps
    end

  end
end
