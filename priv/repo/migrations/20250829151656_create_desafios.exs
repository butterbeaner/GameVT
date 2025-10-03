defmodule Test.Repo.Migrations.CreateDesafios do
  use Ecto.Migration

  def change do
    create table(:desafios) do
      add :desc, :text
      add :user_id, references(:users, type: :id, on_delete: :delete_all)

    end

    create index(:desafios, [:user_id])
  end
end
