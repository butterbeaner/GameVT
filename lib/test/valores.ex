defmodule Test.Valores do
  @moduledoc """
  The Valores context.
  """

  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Valores.Valor
  alias Test.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any valor changes.

  The broadcasted messages match the pattern:

    * {:created, %Valor{}}
    * {:updated, %Valor{}}
    * {:deleted, %Valor{}}

  """
  def subscribe_valores(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Test.PubSub, "user:#{key}:valores")
  end

  defp broadcast_valor(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Test.PubSub, "user:#{key}:valores", message)
  end

  @doc """
  Returns the list of valores.

  ## Example

      iex> list_valores(scope)
      [%Valor{}, ...]

  """
  def list_valores() do
    Repo.all(Valor)
  end

  def random_valor() do
    list_valores()
      |> Enum.take_random(3)
      |> Enum.map(fn x -> Map.values(x) end)
      |> Enum.map(fn x -> Enum.fetch!(x, 1) end)
  end
  @doc """
  Gets a single valor.

  Raises `Ecto.NoResultsError` if the Valor does not exist.

  ## Examples

      iex> get_valor!(scope, 123)
      %Valor{}

      iex> get_valor!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_valor!(%Scope{} = scope, id) do
    Repo.get_by!(Valor, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a valor.

  ## Examples

      iex> create_valor(scope, %{field: value})
      {:ok, %Valor{}}

      iex> create_valor(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_valor(%Scope{} = scope, attrs) do
    with {:ok, valor = %Valor{}} <-
           %Valor{}
           |> Valor.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_valor(scope, {:created, valor})
      {:ok, valor}
    end
  end

  @doc """
  Updates a valor.

  ## Examples

      iex> update_valor(scope, valor, %{field: new_value})
      {:ok, %Valor{}}

      iex> update_valor(scope, valor, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_valor(%Scope{} = scope, %Valor{} = valor, attrs) do
    true = valor.user_id == scope.user.id

    with {:ok, valor = %Valor{}} <-
           valor
           |> Valor.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_valor(scope, {:updated, valor})
      {:ok, valor}
    end
  end

  @doc """
  Deletes a valor.

  ## Examples

      iex> delete_valor(scope, valor)
      {:ok, %Valor{}}

      iex> delete_valor(scope, valor)
      {:error, %Ecto.Changeset{}}

  """
  def delete_valor(%Scope{} = scope, %Valor{} = valor) do
    true = valor.user_id == scope.user.id

    with {:ok, valor = %Valor{}} <-
           Repo.delete(valor) do
      broadcast_valor(scope, {:deleted, valor})
      {:ok, valor}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking valor changes.

  ## Examples

      iex> change_valor(scope, valor)
      %Ecto.Changeset{data: %Valor{}}

  """
  def change_valor(%Scope{} = scope, %Valor{} = valor, attrs \\ %{}) do
    true = valor.user_id == scope.user.id

    Valor.changeset(valor, attrs, scope)
  end
end
