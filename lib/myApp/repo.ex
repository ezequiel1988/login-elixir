defmodule MyApp.Repo do
  use Ecto.Repo,
    otp_app: :myApp,
    adapter: Ecto.Adapters.Postgres
end
