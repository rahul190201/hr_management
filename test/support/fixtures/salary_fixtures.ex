defmodule HrManagement.SalaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HrManagement.Salary` context.
  """

  @doc """
  Generate a salary_payout.
  """
  def salary_payout_fixture(attrs \\ %{}) do
    {:ok, salary_payout} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        payout_date: ~U[2024-02-28 04:06:00Z]
      })
      |> HrManagement.Salary.create_salary_payout()

    salary_payout
  end
end
