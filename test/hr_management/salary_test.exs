defmodule HrManagement.SalaryTest do
  use HrManagement.DataCase

  alias HrManagement.Salary

  describe "salary_payouts" do
    alias HrManagement.Salary.SalaryPayout

    import HrManagement.SalaryFixtures

    @invalid_attrs %{payout_date: nil, amount: nil}

    test "list_salary_payouts/0 returns all salary_payouts" do
      salary_payout = salary_payout_fixture()
      assert Salary.list_salary_payouts() == [salary_payout]
    end

    test "get_salary_payout!/1 returns the salary_payout with given id" do
      salary_payout = salary_payout_fixture()
      assert Salary.get_salary_payout!(salary_payout.id) == salary_payout
    end

    test "create_salary_payout/1 with valid data creates a salary_payout" do
      valid_attrs = %{payout_date: ~U[2024-02-28 04:06:00Z], amount: "120.5"}

      assert {:ok, %SalaryPayout{} = salary_payout} = Salary.create_salary_payout(valid_attrs)
      assert salary_payout.payout_date == ~U[2024-02-28 04:06:00Z]
      assert salary_payout.amount == Decimal.new("120.5")
    end

    test "create_salary_payout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Salary.create_salary_payout(@invalid_attrs)
    end

    test "update_salary_payout/2 with valid data updates the salary_payout" do
      salary_payout = salary_payout_fixture()
      update_attrs = %{payout_date: ~U[2024-02-29 04:06:00Z], amount: "456.7"}

      assert {:ok, %SalaryPayout{} = salary_payout} = Salary.update_salary_payout(salary_payout, update_attrs)
      assert salary_payout.payout_date == ~U[2024-02-29 04:06:00Z]
      assert salary_payout.amount == Decimal.new("456.7")
    end

    test "update_salary_payout/2 with invalid data returns error changeset" do
      salary_payout = salary_payout_fixture()
      assert {:error, %Ecto.Changeset{}} = Salary.update_salary_payout(salary_payout, @invalid_attrs)
      assert salary_payout == Salary.get_salary_payout!(salary_payout.id)
    end

    test "delete_salary_payout/1 deletes the salary_payout" do
      salary_payout = salary_payout_fixture()
      assert {:ok, %SalaryPayout{}} = Salary.delete_salary_payout(salary_payout)
      assert_raise Ecto.NoResultsError, fn -> Salary.get_salary_payout!(salary_payout.id) end
    end

    test "change_salary_payout/1 returns a salary_payout changeset" do
      salary_payout = salary_payout_fixture()
      assert %Ecto.Changeset{} = Salary.change_salary_payout(salary_payout)
    end
  end
end
