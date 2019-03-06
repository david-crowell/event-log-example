defmodule Stateful.Repo.Migrations.ChangeIds do
  use Ecto.Migration

  def up do
    alter table(:orders) do
      remove :id
      add :row_id, :serial, primary_key: true
      add :id, :integer
    end
    execute "CREATE SEQUENCE order_id_sequence"
  end

  def down do
    alter table(:orders) do

    end
  end
end
