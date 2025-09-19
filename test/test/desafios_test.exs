defmodule Test.DesafiosTest do
  use Test.DataCase

  alias Test.Desafios

  describe "desafios" do
    alias Test.Desafios.Desafio

    import Test.AccountsFixtures, only: [user_scope_fixture: 0]
    import Test.DesafiosFixtures

    @invalid_attrs %{desc: nil}

    test "list_desafios/1 returns all scoped desafios" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      other_desafio = desafio_fixture(other_scope)
      assert Desafios.list_desafios(scope) == [desafio]
      assert Desafios.list_desafios(other_scope) == [other_desafio]
    end

    test "get_desafio!/2 returns the desafio with given id" do
      scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      other_scope = user_scope_fixture()
      assert Desafios.get_desafio!(scope, desafio.id) == desafio
      assert_raise Ecto.NoResultsError, fn -> Desafios.get_desafio!(other_scope, desafio.id) end
    end

    test "create_desafio/2 with valid data creates a desafio" do
      valid_attrs = %{desc: "some desc"}
      scope = user_scope_fixture()

      assert {:ok, %Desafio{} = desafio} = Desafios.create_desafio(scope, valid_attrs)
      assert desafio.desc == "some desc"
      assert desafio.user_id == scope.user.id
    end

    test "create_desafio/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Desafios.create_desafio(scope, @invalid_attrs)
    end

    test "update_desafio/3 with valid data updates the desafio" do
      scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      update_attrs = %{desc: "some updated desc"}

      assert {:ok, %Desafio{} = desafio} = Desafios.update_desafio(scope, desafio, update_attrs)
      assert desafio.desc == "some updated desc"
    end

    test "update_desafio/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      desafio = desafio_fixture(scope)

      assert_raise MatchError, fn ->
        Desafios.update_desafio(other_scope, desafio, %{})
      end
    end

    test "update_desafio/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Desafios.update_desafio(scope, desafio, @invalid_attrs)
      assert desafio == Desafios.get_desafio!(scope, desafio.id)
    end

    test "delete_desafio/2 deletes the desafio" do
      scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      assert {:ok, %Desafio{}} = Desafios.delete_desafio(scope, desafio)
      assert_raise Ecto.NoResultsError, fn -> Desafios.get_desafio!(scope, desafio.id) end
    end

    test "delete_desafio/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      assert_raise MatchError, fn -> Desafios.delete_desafio(other_scope, desafio) end
    end

    test "change_desafio/2 returns a desafio changeset" do
      scope = user_scope_fixture()
      desafio = desafio_fixture(scope)
      assert %Ecto.Changeset{} = Desafios.change_desafio(scope, desafio)
    end
  end
end
