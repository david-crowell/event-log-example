defmodule Stateful.OrdersTest do
  use Stateful.DataCase

  alias Stateful.Orders

  describe "orders" do
    alias Stateful.Orders.Order

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Orders.create_order()

      order
    end

    test "list_orders/0 returns only the most recent version of each order" do
      order0_v0 = order_fixture()
      {:ok, order0_v1} = Orders.update_order(order0_v0, @update_attrs)
      {:ok, order0_v2} = Orders.update_order(order0_v1, @update_attrs)

      order1_v0 = order_fixture()
      {:ok, order1_v1} = Orders.update_order(order1_v0, @update_attrs)
      {:ok, order1_v2} = Orders.update_order(order1_v1, @update_attrs)

      assert Orders.list_orders() == [order0_v2, order1_v2]
    end

    test "get_order!/1 returns the order with given id" do
      order0_v0 = order_fixture()
      {:ok, order0_v1} = Orders.update_order(order0_v0, @update_attrs)
      {:ok, order0_v2} = Orders.update_order(order0_v1, @update_attrs)

      order1_v0 = order_fixture()
      {:ok, order1_v1} = Orders.update_order(order1_v0, @update_attrs)
      {:ok, order1_v2} = Orders.update_order(order1_v1, @update_attrs)

      assert Orders.get_order!(order0_v0.id) == order0_v2
      assert Orders.get_order!(order1_v0.id) == order1_v2
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Orders.create_order(@valid_attrs)
      assert order.name == @valid_attrs.name
      assert order.id != nil
      assert order.row_id != nil
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Orders.update_order(order, @update_attrs)
      assert order.name == "some updated name"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
