defmodule Stateful.Orders do
  @moduledoc """
  The Orders context.
  """

  import Ecto.Query, warn: false
  alias Stateful.Repo

  alias Stateful.Orders.Order

  def list_orders do
    query = from o in Order,
      distinct: o.id,
      order_by: [desc: o.inserted_at, desc: o.row_id]

    Repo.all(query)
  end

  def get_order!(id) do
    query = from o in Order,
      distinct: o.id,
      where: o.id == ^id,
      order_by: [desc: o.inserted_at, desc: o.row_id]

    Repo.one!(query)
  end

  def create_order(attrs \\ %{}) do
    attrs = atomize_keys(attrs)
    attrs = insert_next_order_id(attrs)

    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  defp insert_next_order_id(attrs) do
    Map.put(attrs, :id, next_order_id())
  end

  defp next_order_id() do
    {:ok, %{rows: [char_list_representation]}} = Repo.query("SELECT nextval('order_id_sequence')")
    Enum.at(char_list_representation, 0)
  end

  defp has_atom_keys(attrs) do
    keys = Map.keys(attrs)
    if (!Enum.empty?(keys)) do
      is_atom(Enum.at(keys, 0))
    else
      true
    end
  end

  defp atomize_keys(attrs) do
    if has_atom_keys(attrs) do
      attrs
    else
      for {key, val} <- attrs, into: %{}, do: {String.to_atom(key), val}
    end
  end

  def update_order(%Order{} = order, attrs) do
    attrs = atomize_keys(attrs)
    # Extract attrs from existing order, merge in new attrs, delete the primary key
    attrs = order
    |> Map.from_struct()
    |> Map.merge(attrs)
    |> Map.delete(:row_id)

    # Insert new order merging the original fields with the new attrs
    %Order{}
    |> Order.changeset(attrs)
    |> Repo.insert()
  end

  def change_order(%Order{} = order) do
    Order.changeset(order, %{})
  end
end
