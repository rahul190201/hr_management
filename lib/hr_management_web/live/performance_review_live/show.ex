defmodule HrManagementWeb.PerformanceReviewLive.Show do
  use HrManagementWeb, :live_view

  alias HrManagement.Performance

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:performance_review, Performance.get_performance_review!(id))}
  end

  defp page_title(:show), do: "Show Performance review"
  defp page_title(:edit), do: "Edit Performance review"
end
