defmodule Test.Repo.Migrations.AddUniqueIndexes do
  use Ecto.Migration

  def change do
    create unique_index(:novalores, [:desc])
    create unique_index(:valores, [:desc])
    create unique_index(:desafios, [:desc])
  end
end
