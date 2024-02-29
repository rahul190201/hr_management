defmodule HrManagementWeb.SalaryPayoutLive.Show do
  use HrManagementWeb, :live_view

  alias HrManagement.Salary

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:salary_payout, Salary.get_salary_payout!(id))}
  end

  defp page_title(:show), do: "Show Salary payout"
  defp page_title(:edit), do: "Edit Salary payout"
end
