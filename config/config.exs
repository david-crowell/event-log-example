# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :stateful,
  ecto_repos: [Stateful.Repo]

# Configures the endpoint
config :stateful, StatefulWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Til5cdssj+vpMxW4yVSItwArY5C1Ots+Jshc2FoLcsvI9+4pyBQwJRtzkvHr1Fn/",
  render_errors: [view: StatefulWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Stateful.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
