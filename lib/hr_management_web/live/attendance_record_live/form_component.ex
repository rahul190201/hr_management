defmodule HrManagementWeb.AttendanceRecordLive.FormComponent do
  use HrManagementWeb, :live_component

  alias HrManagement.Attendance

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage attendance_record records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="attendance_record-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:clock_in_time]} type="datetime-local" label="Clock in time" />
        <.input field={@form[:clock_out_time]} type="datetime-local" label="Clock out time" />
        <.input field={@form[:date]} type="date" label="Date" default={@date_today} />
        <:actions>
          <.button phx-disable-with="Saving...">Save Attendance record</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{attendance_record: attendance_record} = assigns, socket) do
    changeset = Attendance.change_attendance_record(attendance_record)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:date_today, Date.utc_today())
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"attendance_record" => attendance_record_params}, socket) do
    changeset =
      socket.assigns.attendance_record
      |> Attendance.change_attendance_record(attendance_record_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"attendance_record" => attendance_record_params}, socket) do
    save_attendance_record(socket, socket.assigns.action, attendance_record_params)
  end

  defp save_attendance_record(socket, :edit, attendance_record_params) do
    case Attendance.update_attendance_record(
           socket.assigns.attendance_record,
           attendance_record_params
         ) do
      {:ok, attendance_record} ->
        notify_parent({:saved, attendance_record})

        {:noreply,
         socket
         |> put_flash(:info, "Attendance record updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_attendance_record(socket, :new, attendance_record_params) do
    case Attendance.create_attendance_record(attendance_record_params) do
      {:ok, attendance_record} ->
        notify_parent({:saved, attendance_record})

        {:noreply,
         socket
         |> put_flash(:info, "Attendance record created successfully")
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
