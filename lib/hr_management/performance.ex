defmodule HrManagement.Performance do
  @moduledoc """
  The Performance context.
  """

  import Ecto.Query, warn: false
  alias HrManagement.Repo

  alias HrManagement.Performance.PerformanceReview

  @doc """
  Returns the list of performance_reviews.

  ## Examples

      iex> list_performance_reviews()
      [%PerformanceReview{}, ...]

  """
  def list_performance_reviews do
    Repo.all(PerformanceReview)
  end

  @doc """
  Gets a single performance_review.

  Raises `Ecto.NoResultsError` if the Performance review does not exist.

  ## Examples

      iex> get_performance_review!(123)
      %PerformanceReview{}

      iex> get_performance_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_performance_review!(id), do: Repo.get!(PerformanceReview, id)

  @doc """
  Creates a performance_review.

  ## Examples

      iex> create_performance_review(%{field: value})
      {:ok, %PerformanceReview{}}

      iex> create_performance_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_performance_review(attrs \\ %{}) do
    %PerformanceReview{}
    |> PerformanceReview.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a performance_review.

  ## Examples

      iex> update_performance_review(performance_review, %{field: new_value})
      {:ok, %PerformanceReview{}}

      iex> update_performance_review(performance_review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_performance_review(%PerformanceReview{} = performance_review, attrs) do
    performance_review
    |> PerformanceReview.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a performance_review.

  ## Examples

      iex> delete_performance_review(performance_review)
      {:ok, %PerformanceReview{}}

      iex> delete_performance_review(performance_review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_performance_review(%PerformanceReview{} = performance_review) do
    Repo.delete(performance_review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking performance_review changes.

  ## Examples

      iex> change_performance_review(performance_review)
      %Ecto.Changeset{data: %PerformanceReview{}}

  """
  def change_performance_review(%PerformanceReview{} = performance_review, attrs \\ %{}) do
    PerformanceReview.changeset(performance_review, attrs)
  end
end
