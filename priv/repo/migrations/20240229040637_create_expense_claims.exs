defmodule HrManagement.Repo.Migrations.CreateExpenseClaims do
  use Ecto.Migration

  def change do
    create table(:expense_claims) do
      add :claim_date, :date
      add :amount, :decimal
      add :description, :text
      add :status, :string
      add :employee_id, references(:employees, on_delete: :nothing)

      timestamps()
    end

    create index(:expense_claims, [:employee_id])
  end
end
