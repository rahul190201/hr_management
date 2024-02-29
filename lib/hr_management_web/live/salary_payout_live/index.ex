defmodule HrManagementWeb.SalaryPayoutLive.Index do
  use HrManagementWeb, :live_view

  alias HrManagement.Salary
  alias HrManagement.Salary.SalaryPayout

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :salary_payouts, Salary.list_salary_payouts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Salary payout")
    |> assign(:salary_payout, Salary.get_salary_payout!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Salary payout")
    |> assign(:salary_payout, %SalaryPayout{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Salary payouts")
    |> assign(:salary_payout, nil)
  end

  @impl true
  def handle_info({HrManagementWeb.SalaryPayoutLive.FormComponent, {:saved, salary_payout}}, socket) do
    {:noreply, stream_insert(socket, :salary_payouts, salary_payout)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    salary_payout = Salary.get_salary_payout!(id)
    {:ok, _} = Salary.delete_salary_payout(salary_payout)

    {:noreply, stream_delete(socket, :salary_payouts, salary_payout)}
  end
end
