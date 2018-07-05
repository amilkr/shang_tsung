use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shang_tsung, ShangTsungWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :shang_tsung,
  tsung_config_dir: ".tsung/test/config/",
  tsung_log_dir: ".tsung/test/log/",
  tsung_node_host: "127.0.0.1"

# Configure your database
config :shang_tsung, ShangTsung.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "shang_tsung_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
