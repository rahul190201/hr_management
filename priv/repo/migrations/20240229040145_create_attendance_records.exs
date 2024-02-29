defmodule HrManagement.Repo.Migrations.CreateAttendanceRecords do
  use Ecto.Migration

  def change do
    create table(:attendance_records) do
      add :duration, :time
      add :clock_in_time, :time
      add :clock_out_time, :time
      add :date, :date
      add :employee_id, references(:employees, on_delete: :nothing)

      timestamps()
    end

    create index(:attendance_records, [:employee_id])
  end
end
