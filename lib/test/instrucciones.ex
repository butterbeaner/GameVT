defmodule Test.Instrucciones do
  @moduledoc """
  The Instrucciones context.
  """

  import Ecto.Query, warn: false
  alias Test.Repo

  alias Test.Instrucciones.Instruccion
  alias Test.Accounts.Scope

  @doc """
  Subscribes to scoped notifications about any instruccion changes.

  The broadcasted messages match the pattern:

    * {:created, %Instruccion{}}
    * {:updated, %Instruccion{}}
    * {:deleted, %Instruccion{}}

  """
  def subscribe_instrucciones(%Scope{} = scope) do
    key = scope.user.id

    Phoenix.PubSub.subscribe(Test.PubSub, "user:#{key}:instrucciones")
  end

  defp broadcast_instruccion(%Scope{} = scope, message) do
    key = scope.user.id

    Phoenix.PubSub.broadcast(Test.PubSub, "user:#{key}:instrucciones", message)
  end

  @doc """
  Returns the list of instrucciones.

  ## Examples

      iex> list_instrucciones(scope)
      [%Instruccion{}, ...]

  """
  def list_instrucciones(%Scope{} = scope) do
    Repo.all_by(Instruccion, user_id: scope.user.id)
  end

  @doc """
  Gets a single instruccion.

  Raises `Ecto.NoResultsError` if the Instruccion does not exist.

  ## Examples

      iex> get_instruccion!(scope, 123)
      %Instruccion{}

      iex> get_instruccion!(scope, 456)
      ** (Ecto.NoResultsError)

  """
  def get_instruccion!(%Scope{} = scope, id) do
    Repo.get_by!(Instruccion, id: id, user_id: scope.user.id)
  end

  @doc """
  Creates a instruccion.

  ## Examples

      iex> create_instruccion(scope, %{field: value})
      {:ok, %Instruccion{}}

      iex> create_instruccion(scope, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_instruccion(%Scope{} = scope, attrs) do
    with {:ok, instruccion = %Instruccion{}} <-
           %Instruccion{}
           |> Instruccion.changeset(attrs, scope)
           |> Repo.insert() do
      broadcast_instruccion(scope, {:created, instruccion})
      {:ok, instruccion}
    end
  end

  @doc """
  Updates a instruccion.

  ## Examples

      iex> update_instruccion(scope, instruccion, %{field: new_value})
      {:ok, %Instruccion{}}

      iex> update_instruccion(scope, instruccion, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_instruccion(%Scope{} = scope, %Instruccion{} = instruccion, attrs) do
    true = instruccion.user_id == scope.user.id

    with {:ok, instruccion = %Instruccion{}} <-
           instruccion
           |> Instruccion.changeset(attrs, scope)
           |> Repo.update() do
      broadcast_instruccion(scope, {:updated, instruccion})
      {:ok, instruccion}
    end
  end

  @doc """
  Deletes a instruccion.

  ## Examples

      iex> delete_instruccion(scope, instruccion)
      {:ok, %Instruccion{}}

      iex> delete_instruccion(scope, instruccion)
      {:error, %Ecto.Changeset{}}

  """
  def delete_instruccion(%Scope{} = scope, %Instruccion{} = instruccion) do
    true = instruccion.user_id == scope.user.id

    with {:ok, instruccion = %Instruccion{}} <-
           Repo.delete(instruccion) do
      broadcast_instruccion(scope, {:deleted, instruccion})
      {:ok, instruccion}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking instruccion changes.

  ## Examples

      iex> change_instruccion(scope, instruccion)
      %Ecto.Changeset{data: %Instruccion{}}

  """
  def change_instruccion(%Scope{} = scope, %Instruccion{} = instruccion, attrs \\ %{}) do
    true = instruccion.user_id == scope.user.id

    Instruccion.changeset(instruccion, attrs, scope)
  end
end
