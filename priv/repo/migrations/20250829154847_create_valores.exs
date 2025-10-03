defmodule Test.Repo.Migrations.CreateValores do
  use Ecto.Migration

  def change do
    create table(:valores) do
      add :desc, :text
      add :user_id, references(:users, type: :id, on_delete: :delete_all)
    end

    create index(:valores, [:user_id])
  end
end
