import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web_app, WebAppWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "V1HQilbJHEXK1ECNQSn7Q1SlOW6VlSw7dcXyWYRtOOw2uD2ORjgG3UsyBwjxz+XL",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
