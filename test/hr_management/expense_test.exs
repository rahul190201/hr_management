defmodule HrManagement.ExpenseTest do
  use HrManagement.DataCase

  alias HrManagement.Expense

  describe "expense_claims" do
    alias HrManagement.Expense.ExpenseClaim

    import HrManagement.ExpenseFixtures

    @invalid_attrs %{status: nil, description: nil, claim_date: nil, amount: nil}

    test "list_expense_claims/0 returns all expense_claims" do
      expense_claim = expense_claim_fixture()
      assert Expense.list_expense_claims() == [expense_claim]
    end

    test "get_expense_claim!/1 returns the expense_claim with given id" do
      expense_claim = expense_claim_fixture()
      assert Expense.get_expense_claim!(expense_claim.id) == expense_claim
    end

    test "create_expense_claim/1 with valid data creates a expense_claim" do
      valid_attrs = %{status: "some status", description: "some description", claim_date: ~D[2024-02-28], amount: "120.5"}

      assert {:ok, %ExpenseClaim{} = expense_claim} = Expense.create_expense_claim(valid_attrs)
      assert expense_claim.status == "some status"
      assert expense_claim.description == "some description"
      assert expense_claim.claim_date == ~D[2024-02-28]
      assert expense_claim.amount == Decimal.new("120.5")
    end

    test "create_expense_claim/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Expense.create_expense_claim(@invalid_attrs)
    end

    test "update_expense_claim/2 with valid data updates the expense_claim" do
      expense_claim = expense_claim_fixture()
      update_attrs = %{status: "some updated status", description: "some updated description", claim_date: ~D[2024-02-29], amount: "456.7"}

      assert {:ok, %ExpenseClaim{} = expense_claim} = Expense.update_expense_claim(expense_claim, update_attrs)
      assert expense_claim.status == "some updated status"
      assert expense_claim.description == "some updated description"
      assert expense_claim.claim_date == ~D[2024-02-29]
      assert expense_claim.amount == Decimal.new("456.7")
    end

    test "update_expense_claim/2 with invalid data returns error changeset" do
      expense_claim = expense_claim_fixture()
      assert {:error, %Ecto.Changeset{}} = Expense.update_expense_claim(expense_claim, @invalid_attrs)
      assert expense_claim == Expense.get_expense_claim!(expense_claim.id)
    end

    test "delete_expense_claim/1 deletes the expense_claim" do
      expense_claim = expense_claim_fixture()
      assert {:ok, %ExpenseClaim{}} = Expense.delete_expense_claim(expense_claim)
      assert_raise Ecto.NoResultsError, fn -> Expense.get_expense_claim!(expense_claim.id) end
    end

    test "change_expense_claim/1 returns a expense_claim changeset" do
      expense_claim = expense_claim_fixture()
      assert %Ecto.Changeset{} = Expense.change_expense_claim(expense_claim)
    end
  end
end
