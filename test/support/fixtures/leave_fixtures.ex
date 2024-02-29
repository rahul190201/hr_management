defmodule HrManagement.LeaveFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HrManagement.Leave` context.
  """

  @doc """
  Generate a leave_request.
  """
  def leave_request_fixture(attrs \\ %{}) do
    {:ok, leave_request} =
      attrs
      |> Enum.into(%{
        end_date: ~D[2024-02-28],
        start_date: ~D[2024-02-28],
        status: "some status"
      })
      |> HrManagement.Leave.create_leave_request()

    leave_request
  end
end
