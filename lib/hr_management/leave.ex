defmodule HrManagement.Leave do
  @moduledoc """
  The Leave context.
  """

  import Ecto.Query, warn: false
  alias HrManagement.Repo

  alias HrManagement.Leave.LeaveRequest

  @doc """
  Returns the list of leave_requests.

  ## Examples

      iex> list_leave_requests()
      [%LeaveRequest{}, ...]

  """
  def list_leave_requests do
    Repo.all(LeaveRequest)
  end

  @doc """
  Gets a single leave_request.

  Raises `Ecto.NoResultsError` if the Leave request does not exist.

  ## Examples

      iex> get_leave_request!(123)
      %LeaveRequest{}

      iex> get_leave_request!(456)
      ** (Ecto.NoResultsError)

  """
  def get_leave_request!(id), do: Repo.get!(LeaveRequest, id)

  @doc """
  Creates a leave_request.

  ## Examples

      iex> create_leave_request(%{field: value})
      {:ok, %LeaveRequest{}}

      iex> create_leave_request(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_leave_request(attrs \\ %{}) do
    %LeaveRequest{}
    |> LeaveRequest.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a leave_request.

  ## Examples

      iex> update_leave_request(leave_request, %{field: new_value})
      {:ok, %LeaveRequest{}}

      iex> update_leave_request(leave_request, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_leave_request(%LeaveRequest{} = leave_request, attrs) do
    leave_request
    |> LeaveRequest.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a leave_request.

  ## Examples

      iex> delete_leave_request(leave_request)
      {:ok, %LeaveRequest{}}

      iex> delete_leave_request(leave_request)
      {:error, %Ecto.Changeset{}}

  """
  def delete_leave_request(%LeaveRequest{} = leave_request) do
    Repo.delete(leave_request)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking leave_request changes.

  ## Examples

      iex> change_leave_request(leave_request)
      %Ecto.Changeset{data: %LeaveRequest{}}

  """
  def change_leave_request(%LeaveRequest{} = leave_request, attrs \\ %{}) do
    LeaveRequest.changeset(leave_request, attrs)
  end
end
