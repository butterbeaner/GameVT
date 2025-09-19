defmodule Test.InstruccionesTest do
  use Test.DataCase

  alias Test.Instrucciones

  describe "instrucciones" do
    alias Test.Instrucciones.Instruccion

    import Test.AccountsFixtures, only: [user_scope_fixture: 0]
    import Test.InstruccionesFixtures

    @invalid_attrs %{instruccion: nil}

    test "list_instrucciones/1 returns all scoped instrucciones" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      other_instruccion = instruccion_fixture(other_scope)
      assert Instrucciones.list_instrucciones(scope) == [instruccion]
      assert Instrucciones.list_instrucciones(other_scope) == [other_instruccion]
    end

    test "get_instruccion!/2 returns the instruccion with given id" do
      scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      other_scope = user_scope_fixture()
      assert Instrucciones.get_instruccion!(scope, instruccion.id) == instruccion
      assert_raise Ecto.NoResultsError, fn -> Instrucciones.get_instruccion!(other_scope, instruccion.id) end
    end

    test "create_instruccion/2 with valid data creates a instruccion" do
      valid_attrs = %{instruccion: "some instruccion"}
      scope = user_scope_fixture()

      assert {:ok, %Instruccion{} = instruccion} = Instrucciones.create_instruccion(scope, valid_attrs)
      assert instruccion.instruccion == "some instruccion"
      assert instruccion.user_id == scope.user.id
    end

    test "create_instruccion/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Instrucciones.create_instruccion(scope, @invalid_attrs)
    end

    test "update_instruccion/3 with valid data updates the instruccion" do
      scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      update_attrs = %{instruccion: "some updated instruccion"}

      assert {:ok, %Instruccion{} = instruccion} = Instrucciones.update_instruccion(scope, instruccion, update_attrs)
      assert instruccion.instruccion == "some updated instruccion"
    end

    test "update_instruccion/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)

      assert_raise MatchError, fn ->
        Instrucciones.update_instruccion(other_scope, instruccion, %{})
      end
    end

    test "update_instruccion/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Instrucciones.update_instruccion(scope, instruccion, @invalid_attrs)
      assert instruccion == Instrucciones.get_instruccion!(scope, instruccion.id)
    end

    test "delete_instruccion/2 deletes the instruccion" do
      scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      assert {:ok, %Instruccion{}} = Instrucciones.delete_instruccion(scope, instruccion)
      assert_raise Ecto.NoResultsError, fn -> Instrucciones.get_instruccion!(scope, instruccion.id) end
    end

    test "delete_instruccion/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      assert_raise MatchError, fn -> Instrucciones.delete_instruccion(other_scope, instruccion) end
    end

    test "change_instruccion/2 returns a instruccion changeset" do
      scope = user_scope_fixture()
      instruccion = instruccion_fixture(scope)
      assert %Ecto.Changeset{} = Instrucciones.change_instruccion(scope, instruccion)
    end
  end
end
