defmodule Test.Repo.Migrations.CreateInstrucciones do
  use Ecto.Migration

  def change do
    create table(:instrucciones) do
      add :instruccion, :string
      add :user_id, references(:users, type: :id, on_delete: :delete_all)
      timestamps(default: fragment("NOW()"))

    end

    create index(:instrucciones, [:user_id])
  end
end
