defmodule Stateful.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset


  schema "orders" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
