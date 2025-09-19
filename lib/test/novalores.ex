defmodule Test.Novalores do
  @moduledoc """
  The Novalores context.
  """

  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Novalores.Novalor
  alias Test.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any novalor changes.

  The broadcasted messages match the pattern:

    * {:created, %Novalor{}}
    * {:updated, %Novalor{}}
    * {:deleted, %Novalor{}}

  """
  def subscribe_novalores(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Test.PubSub, "user:#{key}:novalores")
  end

  defp broadcast_novalor(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Test.PubSub, "user:#{key}:novalores", message)
  end

  @doc """
  Returns the list of novalores.

  ## Examples

      iex> list_novalores(scope)
      [%Novalor{}, ...]

  """
  def list_novalores() do
    Repo.all(Novalor)
  end

  def random_novalor() do
    list_novalores()
      |> Enum.take_random(3)
      |> Enum.map(fn x -> Map.values(x) end)
      |> Enum.map(fn x -> Enum.fetch!(x, 1) end)
  end

  @doc """
  Gets a single novalor.

  Raises `Ecto.NoResultsError` if the Novalor does not exist.

  ## Examples

      iex> get_novalor!(scope, 123)
      %Novalor{}

      iex> get_novalor!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_novalor!(%Scope{} = scope, id) do
    Repo.get_by!(Novalor, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a novalor.

  ## Examples

      iex> create_novalor(scope, %{field: value})
      {:ok, %Novalor{}}

      iex> create_novalor(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_novalor(%Scope{} = scope, attrs) do
    with {:ok, novalor = %Novalor{}} <-
           %Novalor{}
           |> Novalor.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_novalor(scope, {:created, novalor})
      {:ok, novalor}
    end
  end

  @doc """
  Updates a novalor.

  ## Examples

      iex> update_novalor(scope, novalor, %{field: new_value})
      {:ok, %Novalor{}}

      iex> update_novalor(scope, novalor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_novalor(%Scope{} = scope, %Novalor{} = novalor, attrs) do
    true = novalor.user_id == scope.user.id

    with {:ok, novalor = %Novalor{}} <-
           novalor
           |> Novalor.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_novalor(scope, {:updated, novalor})
      {:ok, novalor}
    end
  end

  @doc """
  Deletes a novalor.

  ## Examples

      iex> delete_novalor(scope, novalor)
      {:ok, %Novalor{}}

      iex> delete_novalor(scope, novalor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_novalor(%Scope{} = scope, %Novalor{} = novalor) do
    true = novalor.user_id == scope.user.id

    with {:ok, novalor = %Novalor{}} <-
           Repo.delete(novalor) do
      broadcast_novalor(scope, {:deleted, novalor})
      {:ok, novalor}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking novalor changes.

  ## Examples

      iex> change_novalor(scope, novalor)
      %Ecto.Changeset{data: %Novalor{}}

  """
  def change_novalor(%Scope{} = scope, %Novalor{} = novalor, attrs \\ %{}) do
    true = novalor.user_id == scope.user.id

    Novalor.changeset(novalor, attrs, scope)
  end
end
