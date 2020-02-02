use Mix.Config

port = String.to_integer(System.get_env("PORT") || "4000")

config :bank_api, BankApiWeb.Endpoint,
  http: [port: port],
  url: [host: System.get_env("HOSTNAME"), port: port],
  cache_static_manifest: "priv/static/cache_manifest.json",
  version: Application.spec(:bank_api, :vsn),
  server: true,
  root: ".",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :bank_api, BankApi.Repo,
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASS"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_HOST"),
  pool_size: 15

config :bank_api, BankApi.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASS"),
  database: System.get_env("EVENTSTORE_NAME"),
  hostname: System.get_env("EVENTSTORE_HOST"),
  pool_size: 15
