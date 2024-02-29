defmodule HrManagement.Repo.Migrations.CreatePerformanceReviews do
  use Ecto.Migration

  def change do
    create table(:performance_reviews) do
      add :review_date, :date
      add :rating, :integer
      add :feedback, :text
      add :employee_id, references(:employees, on_delete: :nothing)
      add :reviewer_id, references(:employees, on_delete: :nothing)

      timestamps()
    end

    create index(:performance_reviews, [:employee_id])
    create index(:performance_reviews, [:reviewer_id])
  end
end
