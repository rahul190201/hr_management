defmodule HrManagementWeb.LeaveRequestLive.Show do
  use HrManagementWeb, :live_view

  alias HrManagement.Leave

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:leave_request, Leave.get_leave_request!(id))}
  end

  defp page_title(:show), do: "Show Leave request"
  defp page_title(:edit), do: "Edit Leave request"
end
