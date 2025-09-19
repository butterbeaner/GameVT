defmodule Test.InstruccionesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Test.Instrucciones` context.
  """

  @doc """
  Generate a instruccion.
  """
  def instruccion_fixture(scope, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        instruccion: "some instruccion"
      })

    {:ok, instruccion} = Test.Instrucciones.create_instruccion(scope, attrs)
    instruccion
  end
end
