defmodule HrManagementWeb.AttendanceRecordLive.Index do
  use HrManagementWeb, :live_view

  alias HrManagement.Attendance
  alias HrManagement.Attendance.AttendanceRecord

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :attendance_records, Attendance.list_attendance_records())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Attendance record")
    |> assign(:attendance_record, Attendance.get_attendance_record!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Attendance record")
    |> assign(:attendance_record, %AttendanceRecord{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Attendance records")
    |> assign(:attendance_record, nil)
  end

  @impl true
  def handle_info({HrManagementWeb.AttendanceRecordLive.FormComponent, {:saved, attendance_record}}, socket) do
    {:noreply, stream_insert(socket, :attendance_records, attendance_record)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    attendance_record = Attendance.get_attendance_record!(id)
    {:ok, _} = Attendance.delete_attendance_record(attendance_record)

    {:noreply, stream_delete(socket, :attendance_records, attendance_record)}
  end
end
