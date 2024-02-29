defmodule HrManagement.Employees.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  schema "employees" do
    field :name, :string
    field :email, :string
    # Add more fields as needed

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    # Add more validations as needed
  end
end
