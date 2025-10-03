defmodule Test.Novalores do
  import Ecto.Query, warn: false
  alias Test.Repo
  alias Test.Novalores.Novalor

  def changeset(novalor, params) do
    novalor
      |> Ecto.Changeset.cast(params, [:desc])
      |> Ecto.Changeset.validate_required([:desc])
      |> Ecto.Changeset.unique_constraint(:desc)
  end

  def list_novalores() do
    Repo.all(Novalor)
  end

  def random_novalor() do
    list_novalores()
      |> Enum.take_random(3)
      |> Enum.map(fn x -> Map.values(x) end)
      |> Enum.map(fn x -> Enum.fetch!(x, 1) end)
  end


  def create_novalor(desc) do
    %Novalor{}
    |> Novalor.changeset(%{desc: desc})
    |> Repo.insert()
  end

end
