# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bank_api,
  ecto_repos: [BankApi.Repo],
  event_stores: [BankApi.EventStore]

config :bank_api, BankApi.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: BankApi.EventStore
  ],
  pub_sub: :local,
  registry: :local

# Configures the endpoint
config :bank_api, BankApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YN2gAxsnnVU/nM8VvbytffTDx8ep2jbkjiC/MXsM+8/M3U7xAQEbo0r6Fl807Zj7",
  render_errors: [view: BankApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BankApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix, :format_encoders, json: BankApiWeb.Plugs.JSONEncoder

# config for commanded library used for cqrs
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.EventStore,
  consistensy: :strong

# use projections
config :commanded_ecto_projections,
  repo: BankApi.Repo

config :vex,
  sources: [
    BankApi.Support.Validators,
    Vex.Validators
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
