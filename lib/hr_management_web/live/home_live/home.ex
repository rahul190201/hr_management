defmodule HrManagementWeb.HomeLive do
  use HrManagementWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "HR Management System")}
  end
end
