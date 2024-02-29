defmodule HrManagementWeb.LeaveRequestLive.Index do
  use HrManagementWeb, :live_view

  alias HrManagement.Leave
  alias HrManagement.Leave.LeaveRequest

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :leave_requests, Leave.list_leave_requests())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Leave request")
    |> assign(:leave_request, Leave.get_leave_request!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Leave request")
    |> assign(:leave_request, %LeaveRequest{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Leave requests")
    |> assign(:leave_request, nil)
  end

  @impl true
  def handle_info({HrManagementWeb.LeaveRequestLive.FormComponent, {:saved, leave_request}}, socket) do
    {:noreply, stream_insert(socket, :leave_requests, leave_request)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    leave_request = Leave.get_leave_request!(id)
    {:ok, _} = Leave.delete_leave_request(leave_request)

    {:noreply, stream_delete(socket, :leave_requests, leave_request)}
  end
end
