defmodule HrManagementWeb.PerformanceReviewLive.Index do
  use HrManagementWeb, :live_view

  alias HrManagement.Performance
  alias HrManagement.Performance.PerformanceReview

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :performance_reviews, Performance.list_performance_reviews())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Performance review")
    |> assign(:performance_review, Performance.get_performance_review!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Performance review")
    |> assign(:performance_review, %PerformanceReview{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Performance reviews")
    |> assign(:performance_review, nil)
  end

  @impl true
  def handle_info({HrManagementWeb.PerformanceReviewLive.FormComponent, {:saved, performance_review}}, socket) do
    {:noreply, stream_insert(socket, :performance_reviews, performance_review)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    performance_review = Performance.get_performance_review!(id)
    {:ok, _} = Performance.delete_performance_review(performance_review)

    {:noreply, stream_delete(socket, :performance_reviews, performance_review)}
  end
end
