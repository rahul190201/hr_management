defmodule HrManagementWeb.AttendanceRecordLive.Show do
  use HrManagementWeb, :live_view

  alias HrManagement.Attendance

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:attendance_record, Attendance.get_attendance_record!(id))}
  end

  defp page_title(:show), do: "Show Attendance record"
  defp page_title(:edit), do: "Edit Attendance record"
end
