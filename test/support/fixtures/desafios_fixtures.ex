defmodule Test.DesafiosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Test.Desafios` context.
  """

  @doc """
  Generate a desafio.
  """
  def desafio_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        desc: "some desc"
      })

    {:ok, desafio} = Test.Desafios.create_desafio(scope, attrs)
    desafio
  end
end
