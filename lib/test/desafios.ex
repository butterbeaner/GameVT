defmodule Test.Desafios do
  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Desafios.Desafio

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
end
