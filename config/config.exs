# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :redex_demo,
  ecto_repos: [RedexDemo.Repo]

config :redex,
  user_store: Demo.Store,
  shared_stores: %{"shared_conter" => Demo.SharedStore }

# Configures the endpoint
config :redex_demo, RedexDemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yzufYGCDO1qRPxMbPTuRJaIPTqO4DSMKo1lMFMw+Z78J0S4bxyEe6yozgnFMt50o",
  render_errors: [view: RedexDemoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RedexDemo.PubSub,
  live_view: [signing_salt: "ivu7lOpO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
