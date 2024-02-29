defmodule HrManagement.AttendanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HrManagement.Attendance` context.
  """

  @doc """
  Generate a attendance_record.
  """
  def attendance_record_fixture(attrs \\ %{}) do
    {:ok, attendance_record} =
      attrs
      |> Enum.into(%{
        clock_in_time: ~U[2024-02-28 04:01:00Z],
        clock_out_time: ~U[2024-02-28 04:01:00Z],
        date: ~D[2024-02-28]
      })
      |> HrManagement.Attendance.create_attendance_record()

    attendance_record
  end
end
