defmodule HrManagement.Repo do
  use Ecto.Repo,
    otp_app: :hr_management,
    adapter: Ecto.Adapters.Postgres
end
