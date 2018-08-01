use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_api, PhoenixApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_api, PhoenixApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phoenix_api_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox

# Make tests faster by decreased security
config :bcrypt_elixir, :log_rounds, 4
