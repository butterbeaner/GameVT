defmodule Test.Repo.Migrations.CreateNovalores do
  use Ecto.Migration

  def change do
    create table(:novalores) do
      add :desc, :text
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:novalores, [:user_id])
  end
end
