# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :shang_tsung, ShangTsung.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "AaoXtTiuhgqu60g08U5qRR/wRLn5honuArmF2iU1wWyu7/1UpftLLsfWdoj+C4gf",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ShangTsung.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :tsung_controller,
  dumpstats_interval: 2000,
  mon_file: 'mon.log',
  match_log_file: 'match.log',
  log_file: 'tsung.log'

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
