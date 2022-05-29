defmodule Factcheck.Repo do
  use Ecto.Repo,
    otp_app: :factcheck,
    adapter: Ecto.Adapters.Postgres
end
