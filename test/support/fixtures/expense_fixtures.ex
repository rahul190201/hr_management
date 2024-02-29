defmodule HrManagement.ExpenseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HrManagement.Expense` context.
  """

  @doc """
  Generate a expense_claim.
  """
  def expense_claim_fixture(attrs \\ %{}) do
    {:ok, expense_claim} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        claim_date: ~D[2024-02-28],
        description: "some description",
        status: "some status"
      })
      |> HrManagement.Expense.create_expense_claim()

    expense_claim
  end
end
