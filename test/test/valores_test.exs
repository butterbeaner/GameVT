defmodule Test.ValoresTest do
  use Test.DataCase

  alias Test.Valores

  describe "valores" do
    alias Test.Valores.Valor

    import Test.AccountsFixtures, only: [user_scope_fixture: 0]
    import Test.ValoresFixtures

    @invalid_attrs %{desc: nil}

    test "list_valores/1 returns all scoped valores" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      valor = valor_fixture(scope)
      other_valor = valor_fixture(other_scope)
      assert Valores.list_valores(scope) == [valor]
      assert Valores.list_valores(other_scope) == [other_valor]
    end

    test "get_valor!/2 returns the valor with given id" do
      scope = user_scope_fixture()
      valor = valor_fixture(scope)
      other_scope = user_scope_fixture()
      assert Valores.get_valor!(scope, valor.id) == valor
      assert_raise Ecto.NoResultsError, fn -> Valores.get_valor!(other_scope, valor.id) end
    end

    test "create_valor/2 with valid data creates a valor" do
      valid_attrs = %{desc: "some desc"}
      scope = user_scope_fixture()

      assert {:ok, %Valor{} = valor} = Valores.create_valor(scope, valid_attrs)
      assert valor.desc == "some desc"
      assert valor.user_id == scope.user.id
    end

    test "create_valor/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Valores.create_valor(scope, @invalid_attrs)
    end

    test "update_valor/3 with valid data updates the valor" do
      scope = user_scope_fixture()
      valor = valor_fixture(scope)
      update_attrs = %{desc: "some updated desc"}

      assert {:ok, %Valor{} = valor} = Valores.update_valor(scope, valor, update_attrs)
      assert valor.desc == "some updated desc"
    end

    test "update_valor/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      valor = valor_fixture(scope)

      assert_raise MatchError, fn ->
        Valores.update_valor(other_scope, valor, %{})
      end
    end

    test "update_valor/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      valor = valor_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Valores.update_valor(scope, valor, @invalid_attrs)
      assert valor == Valores.get_valor!(scope, valor.id)
    end

    test "delete_valor/2 deletes the valor" do
      scope = user_scope_fixture()
      valor = valor_fixture(scope)
      assert {:ok, %Valor{}} = Valores.delete_valor(scope, valor)
      assert_raise Ecto.NoResultsError, fn -> Valores.get_valor!(scope, valor.id) end
    end

    test "delete_valor/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      valor = valor_fixture(scope)
      assert_raise MatchError, fn -> Valores.delete_valor(other_scope, valor) end
    end

    test "change_valor/2 returns a valor changeset" do
      scope = user_scope_fixture()
      valor = valor_fixture(scope)
      assert %Ecto.Changeset{} = Valores.change_valor(scope, valor)
    end
  end
end
