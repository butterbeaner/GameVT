defmodule Test.Valores.Valor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "valores" do
    field :desc, :string
  end

  @doc false
  def changeset(valor, attrs) do
    valor
    |> cast(attrs, [:desc])
    |> validate_required([:desc])
  end
end
