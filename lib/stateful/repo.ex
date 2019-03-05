defmodule Stateful.Repo do
  use Ecto.Repo,
    otp_app: :stateful,
    adapter: Ecto.Adapters.Postgres
end
