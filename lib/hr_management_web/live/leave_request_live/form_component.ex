defmodule HrManagementWeb.LeaveRequestLive.FormComponent do
  use HrManagementWeb, :live_component

  alias HrManagement.Leave

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage leave_request records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="leave_request-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:start_date]} type="date" label="Start date" />
        <.input field={@form[:end_date]} type="date" label="End date" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Leave request</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{leave_request: leave_request} = assigns, socket) do
    changeset = Leave.change_leave_request(leave_request)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"leave_request" => leave_request_params}, socket) do
    changeset =
      socket.assigns.leave_request
      |> Leave.change_leave_request(leave_request_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"leave_request" => leave_request_params}, socket) do
    save_leave_request(socket, socket.assigns.action, leave_request_params)
  end

  defp save_leave_request(socket, :edit, leave_request_params) do
    case Leave.update_leave_request(socket.assigns.leave_request, leave_request_params) do
      {:ok, leave_request} ->
        notify_parent({:saved, leave_request})

        {:noreply,
         socket
         |> put_flash(:info, "Leave request updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_leave_request(socket, :new, leave_request_params) do
    case Leave.create_leave_request(leave_request_params) do
      {:ok, leave_request} ->
        notify_parent({:saved, leave_request})

        {:noreply,
         socket
         |> put_flash(:info, "Leave request created successfully")
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
