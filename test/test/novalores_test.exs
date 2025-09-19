defmodule Test.NovaloresTest do
  use Test.DataCase

  alias Test.Novalores

  describe "novalores" do
    alias Test.Novalores.Novalor

    import Test.AccountsFixtures, only: [user_scope_fixture: 0]
    import Test.NovaloresFixtures

    @invalid_attrs %{desc: nil}

    test "list_novalores/1 returns all scoped novalores" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      other_novalor = novalor_fixture(other_scope)
      assert Novalores.list_novalores(scope) == [novalor]
      assert Novalores.list_novalores(other_scope) == [other_novalor]
    end

    test "get_novalor!/2 returns the novalor with given id" do
      scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      other_scope = user_scope_fixture()
      assert Novalores.get_novalor!(scope, novalor.id) == novalor
      assert_raise Ecto.NoResultsError, fn -> Novalores.get_novalor!(other_scope, novalor.id) end
    end

    test "create_novalor/2 with valid data creates a novalor" do
      valid_attrs = %{desc: "some desc"}
      scope = user_scope_fixture()

      assert {:ok, %Novalor{} = novalor} = Novalores.create_novalor(scope, valid_attrs)
      assert novalor.desc == "some desc"
      assert novalor.user_id == scope.user.id
    end

    test "create_novalor/2 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      assert {:error, %Ecto.Changeset{}} = Novalores.create_novalor(scope, @invalid_attrs)
    end

    test "update_novalor/3 with valid data updates the novalor" do
      scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      update_attrs = %{desc: "some updated desc"}

      assert {:ok, %Novalor{} = novalor} = Novalores.update_novalor(scope, novalor, update_attrs)
      assert novalor.desc == "some updated desc"
    end

    test "update_novalor/3 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      novalor = novalor_fixture(scope)

      assert_raise MatchError, fn ->
        Novalores.update_novalor(other_scope, novalor, %{})
      end
    end

    test "update_novalor/3 with invalid data returns error changeset" do
      scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      assert {:error, %Ecto.Changeset{}} = Novalores.update_novalor(scope, novalor, @invalid_attrs)
      assert novalor == Novalores.get_novalor!(scope, novalor.id)
    end

    test "delete_novalor/2 deletes the novalor" do
      scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      assert {:ok, %Novalor{}} = Novalores.delete_novalor(scope, novalor)
      assert_raise Ecto.NoResultsError, fn -> Novalores.get_novalor!(scope, novalor.id) end
    end

    test "delete_novalor/2 with invalid scope raises" do
      scope = user_scope_fixture()
      other_scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      assert_raise MatchError, fn -> Novalores.delete_novalor(other_scope, novalor) end
    end

    test "change_novalor/2 returns a novalor changeset" do
      scope = user_scope_fixture()
      novalor = novalor_fixture(scope)
      assert %Ecto.Changeset{} = Novalores.change_novalor(scope, novalor)
    end
  end
end
