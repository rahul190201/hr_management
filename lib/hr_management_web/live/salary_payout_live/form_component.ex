defmodule HrManagementWeb.SalaryPayoutLive.FormComponent do
  use HrManagementWeb, :live_component

  alias HrManagement.Salary

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage salary_payout records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="salary_payout-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:payout_date]} type="datetime-local" label="Payout date" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Salary payout</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{salary_payout: salary_payout} = assigns, socket) do
    changeset = Salary.change_salary_payout(salary_payout)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"salary_payout" => salary_payout_params}, socket) do
    changeset =
      socket.assigns.salary_payout
      |> Salary.change_salary_payout(salary_payout_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"salary_payout" => salary_payout_params}, socket) do
    save_salary_payout(socket, socket.assigns.action, salary_payout_params)
  end

  defp save_salary_payout(socket, :edit, salary_payout_params) do
    case Salary.update_salary_payout(socket.assigns.salary_payout, salary_payout_params) do
      {:ok, salary_payout} ->
        notify_parent({:saved, salary_payout})

        {:noreply,
         socket
         |> put_flash(:info, "Salary payout updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_salary_payout(socket, :new, salary_payout_params) do
    case Salary.create_salary_payout(salary_payout_params) do
      {:ok, salary_payout} ->
        notify_parent({:saved, salary_payout})

        {:noreply,
         socket
         |> put_flash(:info, "Salary payout created successfully")
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
