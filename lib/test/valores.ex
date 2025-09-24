defmodule Test.Valores do
  import Ecto.Query, warn: false
  alias Test.Repo
  alias Test.Valores.Valor
  alias Test.Accounts.Scope

  def list_valores() do
    Repo.all(Valor)
  end

  def random_valor() do
    list_valores()
      |> Enum.take_random(3)
      |> Enum.map(fn x -> Map.values(x) end)
      |> Enum.map(fn x -> Enum.fetch!(x, 1) end)
  end
end
