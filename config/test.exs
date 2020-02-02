use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :bank_api, BankApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :bank_api, BankApi.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: "postgres",
  database: "bank_api_eventstore_test",
  hostname: "localhost",
  pool_size: 1

config :bank_api, BankApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "bank_api_readstore_test",
  hostname: "localhost",
  pool_size: 1

# commanded config
config :commanded,
  event_store_adapter: Commanded.EventStore.Adapters.InMemory,
  consistency: :strong

config :commanded, Commanded.EventStore.Adapters.InMemory,
  serializer: Commanded.Serialization.JsonSerializer
