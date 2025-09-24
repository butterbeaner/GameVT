defmodule Test.Novalores do

  import Ecto.Query, warn: false
  alias Test.Repo
  alias Test.Novalores.Novalor
  alias Test.Accounts.Scope


  def list_novalores() do
    Repo.all(Novalor)
  end

  def random_novalor() do
    list_novalores()
      |> Enum.take_random(3)
      |> Enum.map(fn x -> Map.values(x) end)
      |> Enum.map(fn x -> Enum.fetch!(x, 1) end)
  end

end
