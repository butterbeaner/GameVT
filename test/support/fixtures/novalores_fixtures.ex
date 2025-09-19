defmodule Test.NovaloresFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Test.Novalores` context.
  """

  @doc """
  Generate a novalor.
  """
  def novalor_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        desc: "some desc"
      })

    {:ok, novalor} = Test.Novalores.create_novalor(scope, attrs)
    novalor
  end
end
