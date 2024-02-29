defmodule HrManagement.Expense.ExpenseClaim do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expense_claims" do
    field :status, :string
    field :description, :string
    field :claim_date, :date
    field :amount, :decimal
    field :employee_id, :id

    timestamps()
  end

  @doc false
  def changeset(expense_claim, attrs) do
    expense_claim
    |> cast(attrs, [:claim_date, :amount, :description, :status])
    |> validate_required([:claim_date, :amount, :description, :status])
  end
end
