defmodule HrManagementWeb.ExpenseClaimLive.Index do
  use HrManagementWeb, :live_view

  alias HrManagement.Expense
  alias HrManagement.Expense.ExpenseClaim

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :expense_claims, Expense.list_expense_claims())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Expense claim")
    |> assign(:expense_claim, Expense.get_expense_claim!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Expense claim")
    |> assign(:expense_claim, %ExpenseClaim{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Expense claims")
    |> assign(:expense_claim, nil)
  end

  @impl true
  def handle_info({HrManagementWeb.ExpenseClaimLive.FormComponent, {:saved, expense_claim}}, socket) do
    {:noreply, stream_insert(socket, :expense_claims, expense_claim)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    expense_claim = Expense.get_expense_claim!(id)
    {:ok, _} = Expense.delete_expense_claim(expense_claim)

    {:noreply, stream_delete(socket, :expense_claims, expense_claim)}
  end
end
