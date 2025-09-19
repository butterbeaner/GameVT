defmodule Test.Instrucciones.Instruccion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "instrucciones" do
    field :instruccion, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(instruccion, attrs, user_scope) do
    instruccion
    |> cast(attrs, [:instruccion])
    |> validate_required([:instruccion])
    |> put_change(:user_id, user_scope.user.id)
  end
end
