defmodule Test.Desafios.Desafio do
  use Ecto.Schema
  import Ecto.Changeset

  schema "desafios" do
    field :desc, :string
  end

  @doc false
  def changeset(desafio, attrs) do
    desafio
    |> cast(attrs, [:desc])
    |> validate_required([:desc])
  end
end
