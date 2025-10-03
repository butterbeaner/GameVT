defmodule Test.Valores do
  import Ecto.Query, warn: false
  alias Test.Repo
  alias Test.Valores.Valor

  def changeset(valor, params) do
    valor
      |> Ecto.Changeset.cast(params, [:desc])
      |> Ecto.Changeset.validate_required([:desc])
      |> Ecto.Changeset.unique_constraint(:desc)
  end

  def list_valores() do
    Repo.all(Valor)
  end

  def random_valor() do
    list_valores()
      |> Enum.take_random(3)
      |> Enum.map(fn x -> Map.values(x) end)
      |> Enum.map(fn x -> Enum.fetch!(x, 1) end)
  end

  def create_valor(desc) do
    %Valor{}
    |> Valor.changeset(%{desc: desc})
    |> Repo.insert()
  end
end
