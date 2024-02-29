defmodule HrManagement.Salary.SalaryPayout do
  use Ecto.Schema
  import Ecto.Changeset

  schema "salary_payouts" do
    field :payout_date, :utc_datetime
    field :amount, :decimal
    field :employee_id, :id

    timestamps()
  end

  @doc false
  def changeset(salary_payout, attrs) do
    salary_payout
    |> cast(attrs, [:payout_date, :amount])
    |> validate_required([:payout_date, :amount])
  end
end
