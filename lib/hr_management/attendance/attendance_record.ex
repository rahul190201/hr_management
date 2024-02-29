defmodule HrManagement.Attendance.AttendanceRecord do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attendance_records" do
    field :date, :date
    field :duration, :time
    field :clock_in_time, :time
    field :clock_out_time, :time
    field :employee_id, :id

    timestamps()
  end

  @doc false
  def changeset(attendance_record, attrs) do
    attendance_record
    |> cast(attrs, [:clock_in_time, :clock_out_time, :date])
    |> validate_required([:clock_in_time, :clock_out_time, :date])
  end
end
