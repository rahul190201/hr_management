defmodule HrManagement.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :name, :string
      add :email, :string
      # Add more columns as needed

      timestamps()
    end
  end
end
