# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :shang_tsung,
  ecto_repos: [ShangTsung.Repo]

# Configures the endpoint
config :shang_tsung, ShangTsungWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ov7CrxL7To3i3xQgDPKIhqd/nS2ma0UzXCqwQnMigXDv6pc1t4aTkR+SgtLt0L3M",
  render_errors: [view: ShangTsungWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShangTsung.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :tsung_controller,
  dumpstats_interval: 2000,
  mon_file: 'mon.log',
  match_log_file: 'match.log',
  log_file: 'tsung.log'

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
