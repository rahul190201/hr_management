defmodule HrManagement.Performance.PerformanceReview do
  use Ecto.Schema
  import Ecto.Changeset

  schema "performance_reviews" do
    field :review_date, :date
    field :rating, :integer
    field :feedback, :string
    field :employee_id, :id
    field :reviewer_id, :id

    timestamps()
  end

  @doc false
  def changeset(performance_review, attrs) do
    performance_review
    |> cast(attrs, [:review_date, :rating, :feedback])
    |> validate_required([:review_date, :rating, :feedback])
  end
end
