defmodule HrManagementWeb.PerformanceReviewLive.FormComponent do
  use HrManagementWeb, :live_component

  alias HrManagement.Performance

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage performance_review records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="performance_review-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:review_date]} type="date" label="Review date" />
        <.input field={@form[:rating]} type="number" label="Rating" />
        <.input field={@form[:feedback]} type="text" label="Feedback" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Performance review</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{performance_review: performance_review} = assigns, socket) do
    changeset = Performance.change_performance_review(performance_review)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"performance_review" => performance_review_params}, socket) do
    changeset =
      socket.assigns.performance_review
      |> Performance.change_performance_review(performance_review_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"performance_review" => performance_review_params}, socket) do
    save_performance_review(socket, socket.assigns.action, performance_review_params)
  end

  defp save_performance_review(socket, :edit, performance_review_params) do
    case Performance.update_performance_review(socket.assigns.performance_review, performance_review_params) do
      {:ok, performance_review} ->
        notify_parent({:saved, performance_review})

        {:noreply,
         socket
         |> put_flash(:info, "Performance review updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_performance_review(socket, :new, performance_review_params) do
    case Performance.create_performance_review(performance_review_params) do
      {:ok, performance_review} ->
        notify_parent({:saved, performance_review})

        {:noreply,
         socket
         |> put_flash(:info, "Performance review created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
