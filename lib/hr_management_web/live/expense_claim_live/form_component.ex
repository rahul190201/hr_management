defmodule HrManagementWeb.ExpenseClaimLive.FormComponent do
  use HrManagementWeb, :live_component

  alias HrManagement.Expense

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage expense_claim records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="expense_claim-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:claim_date]} type="date" label="Claim date" />
        <.input field={@form[:amount]} type="number" label="Amount" step="any" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Expense claim</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{expense_claim: expense_claim} = assigns, socket) do
    changeset = Expense.change_expense_claim(expense_claim)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"expense_claim" => expense_claim_params}, socket) do
    changeset =
      socket.assigns.expense_claim
      |> Expense.change_expense_claim(expense_claim_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"expense_claim" => expense_claim_params}, socket) do
    save_expense_claim(socket, socket.assigns.action, expense_claim_params)
  end

  defp save_expense_claim(socket, :edit, expense_claim_params) do
    case Expense.update_expense_claim(socket.assigns.expense_claim, expense_claim_params) do
      {:ok, expense_claim} ->
        notify_parent({:saved, expense_claim})

        {:noreply,
         socket
         |> put_flash(:info, "Expense claim updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_expense_claim(socket, :new, expense_claim_params) do
    case Expense.create_expense_claim(expense_claim_params) do
      {:ok, expense_claim} ->
        notify_parent({:saved, expense_claim})

        {:noreply,
         socket
         |> put_flash(:info, "Expense claim created successfully")
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
