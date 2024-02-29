defmodule HrManagement.AttendanceTest do
  use HrManagement.DataCase

  alias HrManagement.Attendance

  describe "attendance_records" do
    alias HrManagement.Attendance.AttendanceRecord

    import HrManagement.AttendanceFixtures

    @invalid_attrs %{date: nil, clock_in_time: nil, clock_out_time: nil}

    test "list_attendance_records/0 returns all attendance_records" do
      attendance_record = attendance_record_fixture()
      assert Attendance.list_attendance_records() == [attendance_record]
    end

    test "get_attendance_record!/1 returns the attendance_record with given id" do
      attendance_record = attendance_record_fixture()
      assert Attendance.get_attendance_record!(attendance_record.id) == attendance_record
    end

    test "create_attendance_record/1 with valid data creates a attendance_record" do
      valid_attrs = %{date: ~D[2024-02-28], clock_in_time: ~U[2024-02-28 04:01:00Z], clock_out_time: ~U[2024-02-28 04:01:00Z]}

      assert {:ok, %AttendanceRecord{} = attendance_record} = Attendance.create_attendance_record(valid_attrs)
      assert attendance_record.date == ~D[2024-02-28]
      assert attendance_record.clock_in_time == ~U[2024-02-28 04:01:00Z]
      assert attendance_record.clock_out_time == ~U[2024-02-28 04:01:00Z]
    end

    test "create_attendance_record/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Attendance.create_attendance_record(@invalid_attrs)
    end

    test "update_attendance_record/2 with valid data updates the attendance_record" do
      attendance_record = attendance_record_fixture()
      update_attrs = %{date: ~D[2024-02-29], clock_in_time: ~U[2024-02-29 04:01:00Z], clock_out_time: ~U[2024-02-29 04:01:00Z]}

      assert {:ok, %AttendanceRecord{} = attendance_record} = Attendance.update_attendance_record(attendance_record, update_attrs)
      assert attendance_record.date == ~D[2024-02-29]
      assert attendance_record.clock_in_time == ~U[2024-02-29 04:01:00Z]
      assert attendance_record.clock_out_time == ~U[2024-02-29 04:01:00Z]
    end

    test "update_attendance_record/2 with invalid data returns error changeset" do
      attendance_record = attendance_record_fixture()
      assert {:error, %Ecto.Changeset{}} = Attendance.update_attendance_record(attendance_record, @invalid_attrs)
      assert attendance_record == Attendance.get_attendance_record!(attendance_record.id)
    end

    test "delete_attendance_record/1 deletes the attendance_record" do
      attendance_record = attendance_record_fixture()
      assert {:ok, %AttendanceRecord{}} = Attendance.delete_attendance_record(attendance_record)
      assert_raise Ecto.NoResultsError, fn -> Attendance.get_attendance_record!(attendance_record.id) end
    end

    test "change_attendance_record/1 returns a attendance_record changeset" do
      attendance_record = attendance_record_fixture()
      assert %Ecto.Changeset{} = Attendance.change_attendance_record(attendance_record)
    end
  end
end
