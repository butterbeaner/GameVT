defmodule Test.Desafios do
  @moduledoc """
  The Desafios context.
  """

  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Desafios.Desafio
  alias Test.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any desafio changes.

  The broadcasted messages match the pattern:

    * {:created, %Desafio{}}
    * {:updated, %Desafio{}}
    * {:deleted, %Desafio{}}

  """
  def subscribe_desafios(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Test.PubSub, "user:#{key}:desafios")
  end

  defp broadcast_desafio(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Test.PubSub, "user:#{key}:desafios", message)
  end

  @doc """
  Returns the list of desafios.

  ## Examples

      iex> list_desafios(scope)
      [%Desafio{}, ...]

  """
  def list_desafios() do
    Repo.all(Desafio)
  end

  def random_desafio() do
    %{desc: desc} = list_desafios()
    |> Enum.random()
    desc
  end

  @doc """
  Gets a single desafio.

  Raises `Ecto.NoResultsError` if the Desafio does not exist.

  ## Examples

      iex> get_desafio!(scope, 123)
      %Desafio{}

      iex> get_desafio!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_desafio!(%Scope{} = scope, id) do
    Repo.get_by!(Desafio, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a desafio.

  ## Examples

      iex> create_desafio(scope, %{field: value})
      {:ok, %Desafio{}}

      iex> create_desafio(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_desafio(%Scope{} = scope, attrs) do
    with {:ok, desafio = %Desafio{}} <-
           %Desafio{}
           |> Desafio.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_desafio(scope, {:created, desafio})
      {:ok, desafio}
    end
  end

  @doc """
  Updates a desafio.

  ## Examples

      iex> update_desafio(scope, desafio, %{field: new_value})
      {:ok, %Desafio{}}

      iex> update_desafio(scope, desafio, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_desafio(%Scope{} = scope, %Desafio{} = desafio, attrs) do
    true = desafio.user_id == scope.user.id

    with {:ok, desafio = %Desafio{}} <-
           desafio
           |> Desafio.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_desafio(scope, {:updated, desafio})
      {:ok, desafio}
    end
  end

  @doc """
  Deletes a desafio.

  ## Examples

      iex> delete_desafio(scope, desafio)
      {:ok, %Desafio{}}

      iex> delete_desafio(scope, desafio)
      {:error, %Ecto.Changeset{}}

  """
  def delete_desafio(%Scope{} = scope, %Desafio{} = desafio) do
    true = desafio.user_id == scope.user.id

    with {:ok, desafio = %Desafio{}} <-
           Repo.delete(desafio) do
      broadcast_desafio(scope, {:deleted, desafio})
      {:ok, desafio}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking desafio changes.

  ## Examples

      iex> change_desafio(scope, desafio)
      %Ecto.Changeset{data: %Desafio{}}

  """
  def change_desafio(%Scope{} = scope, %Desafio{} = desafio, attrs \\ %{}) do
    true = desafio.user_id == scope.user.id

    Desafio.changeset(desafio, attrs, scope)
  end
end
