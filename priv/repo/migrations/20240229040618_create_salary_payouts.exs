defmodule HrManagement.Repo.Migrations.CreateSalaryPayouts do
  use Ecto.Migration

  def change do
    create table(:salary_payouts) do
      add :payout_date, :utc_datetime
      add :amount, :decimal
      add :employee_id, references(:employees, on_delete: :nothing)

      timestamps()
    end

    create index(:salary_payouts, [:employee_id])
  end
end
