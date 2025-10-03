defmodule Test.Desafios do
  import Ecto.Query, warn: false
  alias Test.Repo
  alias Test.Desafios.Desafio

  def changeset(desafio, params \\ %{}) do
    desafio
      |> Ecto.Changeset.cast(params, [:desc])
      |> Ecto.Changeset.validate_required([:desc])
      |> Ecto.Changeset.unique_constraint(:desc)
  end

  def list_desafios() do
    Repo.all(Desafio)
  end

  def random_desafio() do
    %{desc: desc} = list_desafios()
    |> Enum.random()
#    |> Enum.at(0)
#    IO.puts(desc)
    desc
  end
  def create_desafio(desc) do
    %Desafio{}
    |> Desafio.changeset(%{desc: desc})
    |> Repo.insert()
  end
end
