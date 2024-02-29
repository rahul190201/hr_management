defmodule HrManagementWeb.AttendanceRecordLiveTest do
  use HrManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import HrManagement.AttendanceFixtures

  @create_attrs %{date: "2024-02-28", clock_in_time: "2024-02-28T04:01:00Z", clock_out_time: "2024-02-28T04:01:00Z"}
  @update_attrs %{date: "2024-02-29", clock_in_time: "2024-02-29T04:01:00Z", clock_out_time: "2024-02-29T04:01:00Z"}
  @invalid_attrs %{date: nil, clock_in_time: nil, clock_out_time: nil}

  defp create_attendance_record(_) do
    attendance_record = attendance_record_fixture()
    %{attendance_record: attendance_record}
  end

  describe "Index" do
    setup [:create_attendance_record]

    test "lists all attendance_records", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/attendance_records")

      assert html =~ "Listing Attendance records"
    end

    test "saves new attendance_record", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/attendance_records")

      assert index_live |> element("a", "New Attendance record") |> render_click() =~
               "New Attendance record"

      assert_patch(index_live, ~p"/attendance_records/new")

      assert index_live
             |> form("#attendance_record-form", attendance_record: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#attendance_record-form", attendance_record: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/attendance_records")

      html = render(index_live)
      assert html =~ "Attendance record created successfully"
    end

    test "updates attendance_record in listing", %{conn: conn, attendance_record: attendance_record} do
      {:ok, index_live, _html} = live(conn, ~p"/attendance_records")

      assert index_live |> element("#attendance_records-#{attendance_record.id} a", "Edit") |> render_click() =~
               "Edit Attendance record"

      assert_patch(index_live, ~p"/attendance_records/#{attendance_record}/edit")

      assert index_live
             |> form("#attendance_record-form", attendance_record: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#attendance_record-form", attendance_record: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/attendance_records")

      html = render(index_live)
      assert html =~ "Attendance record updated successfully"
    end

    test "deletes attendance_record in listing", %{conn: conn, attendance_record: attendance_record} do
      {:ok, index_live, _html} = live(conn, ~p"/attendance_records")

      assert index_live |> element("#attendance_records-#{attendance_record.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#attendance_records-#{attendance_record.id}")
    end
  end

  describe "Show" do
    setup [:create_attendance_record]

    test "displays attendance_record", %{conn: conn, attendance_record: attendance_record} do
      {:ok, _show_live, html} = live(conn, ~p"/attendance_records/#{attendance_record}")

      assert html =~ "Show Attendance record"
    end

    test "updates attendance_record within modal", %{conn: conn, attendance_record: attendance_record} do
      {:ok, show_live, _html} = live(conn, ~p"/attendance_records/#{attendance_record}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Attendance record"

      assert_patch(show_live, ~p"/attendance_records/#{attendance_record}/show/edit")

      assert show_live
             |> form("#attendance_record-form", attendance_record: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#attendance_record-form", attendance_record: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/attendance_records/#{attendance_record}")

      html = render(show_live)
      assert html =~ "Attendance record updated successfully"
    end
  end
end
