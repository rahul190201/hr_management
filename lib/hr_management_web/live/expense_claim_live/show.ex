defmodule HrManagementWeb.ExpenseClaimLive.Show do
  use HrManagementWeb, :live_view

  alias HrManagement.Expense

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:expense_claim, Expense.get_expense_claim!(id))}
  end

  defp page_title(:show), do: "Show Expense claim"
  defp page_title(:edit), do: "Edit Expense claim"
end
