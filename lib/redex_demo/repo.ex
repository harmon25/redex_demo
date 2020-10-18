defmodule RedexDemo.Repo do
  use Ecto.Repo,
    otp_app: :redex_demo,
    adapter: Ecto.Adapters.Postgres
end
