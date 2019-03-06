defmodule Stateful.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:row_id, :id, autogenerate: true}
  schema "orders" do
    # field :row_id, :integer, primary_key: true, read_after_writes: true
    field :name, :string
    field :id, :integer

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:name, :id, :row_id])
    |> validate_required([:name])
  end
end
