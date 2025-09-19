defmodule Test.Novalores.Novalor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "novalores" do
    field :desc, :string
  end

  @doc false
  def changeset(novalor, attrs) do
    novalor
    |> cast(attrs, [:desc])
    |> validate_required([:desc])
  end
end
