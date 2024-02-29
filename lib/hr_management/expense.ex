defmodule HrManagement.Expense do
  @moduledoc """
  The Expense context.
  """

  import Ecto.Query, warn: false
  alias HrManagement.Repo

  alias HrManagement.Expense.ExpenseClaim

  @doc """
  Returns the list of expense_claims.

  ## Examples

      iex> list_expense_claims()
      [%ExpenseClaim{}, ...]

  """
  def list_expense_claims do
    Repo.all(ExpenseClaim)
  end

  @doc """
  Gets a single expense_claim.

  Raises `Ecto.NoResultsError` if the Expense claim does not exist.

  ## Examples

      iex> get_expense_claim!(123)
      %ExpenseClaim{}

      iex> get_expense_claim!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense_claim!(id), do: Repo.get!(ExpenseClaim, id)

  @doc """
  Creates a expense_claim.

  ## Examples

      iex> create_expense_claim(%{field: value})
      {:ok, %ExpenseClaim{}}

      iex> create_expense_claim(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense_claim(attrs \\ %{}) do
    %ExpenseClaim{}
    |> ExpenseClaim.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense_claim.

  ## Examples

      iex> update_expense_claim(expense_claim, %{field: new_value})
      {:ok, %ExpenseClaim{}}

      iex> update_expense_claim(expense_claim, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense_claim(%ExpenseClaim{} = expense_claim, attrs) do
    expense_claim
    |> ExpenseClaim.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expense_claim.

  ## Examples

      iex> delete_expense_claim(expense_claim)
      {:ok, %ExpenseClaim{}}

      iex> delete_expense_claim(expense_claim)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense_claim(%ExpenseClaim{} = expense_claim) do
    Repo.delete(expense_claim)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense_claim changes.

  ## Examples

      iex> change_expense_claim(expense_claim)
      %Ecto.Changeset{data: %ExpenseClaim{}}

  """
  def change_expense_claim(%ExpenseClaim{} = expense_claim, attrs \\ %{}) do
    ExpenseClaim.changeset(expense_claim, attrs)
  end
end
