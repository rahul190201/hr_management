defmodule HrManagement.Leave.LeaveRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leave_requests" do
    field :status, :string
    field :start_date, :date
    field :end_date, :date
    field :employee_id, :id

    timestamps()
  end

  @doc false
  def changeset(leave_request, attrs) do
    leave_request
    |> cast(attrs, [:start_date, :end_date, :status])
    |> validate_required([:start_date, :end_date, :status])
  end
end
