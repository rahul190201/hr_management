defmodule HrManagement.Salary do
  @moduledoc """
  The Salary context.
  """

  import Ecto.Query, warn: false
  alias HrManagement.Repo

  alias HrManagement.Salary.SalaryPayout

  @doc """
  Returns the list of salary_payouts.

  ## Examples

      iex> list_salary_payouts()
      [%SalaryPayout{}, ...]

  """
  def list_salary_payouts do
    Repo.all(SalaryPayout)
  end

  @doc """
  Gets a single salary_payout.

  Raises `Ecto.NoResultsError` if the Salary payout does not exist.

  ## Examples

      iex> get_salary_payout!(123)
      %SalaryPayout{}

      iex> get_salary_payout!(456)
      ** (Ecto.NoResultsError)

  """
  def get_salary_payout!(id), do: Repo.get!(SalaryPayout, id)

  @doc """
  Creates a salary_payout.

  ## Examples

      iex> create_salary_payout(%{field: value})
      {:ok, %SalaryPayout{}}

      iex> create_salary_payout(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_salary_payout(attrs \\ %{}) do
    %SalaryPayout{}
    |> SalaryPayout.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a salary_payout.

  ## Examples

      iex> update_salary_payout(salary_payout, %{field: new_value})
      {:ok, %SalaryPayout{}}

      iex> update_salary_payout(salary_payout, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_salary_payout(%SalaryPayout{} = salary_payout, attrs) do
    salary_payout
    |> SalaryPayout.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a salary_payout.

  ## Examples

      iex> delete_salary_payout(salary_payout)
      {:ok, %SalaryPayout{}}

      iex> delete_salary_payout(salary_payout)
      {:error, %Ecto.Changeset{}}

  """
  def delete_salary_payout(%SalaryPayout{} = salary_payout) do
    Repo.delete(salary_payout)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking salary_payout changes.

  ## Examples

      iex> change_salary_payout(salary_payout)
      %Ecto.Changeset{data: %SalaryPayout{}}

  """
  def change_salary_payout(%SalaryPayout{} = salary_payout, attrs \\ %{}) do
    SalaryPayout.changeset(salary_payout, attrs)
  end
end
