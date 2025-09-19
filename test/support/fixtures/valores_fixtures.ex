defmodule Test.ValoresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Test.Valores` context.
  """

  @doc """
  Generate a valor.
  """
  def valor_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        desc: "some desc"
      })

    {:ok, valor} = Test.Valores.create_valor(scope, attrs)
    valor
  end
end
