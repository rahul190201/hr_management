defmodule HrManagement.Repo.Migrations.CreateLeaveRequests do
  use Ecto.Migration

  def change do
    create table(:leave_requests) do
      add :start_date, :date
      add :end_date, :date
      add :status, :string
      add :employee_id, references(:employees, on_delete: :nothing)

      timestamps()
    end

    create index(:leave_requests, [:employee_id])
  end
end
