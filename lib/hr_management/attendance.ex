defmodule HrManagement.Attendance do
  @moduledoc """
  The Attendance context.
  """

  import Ecto.Query, warn: false
  alias HrManagement.Repo

  alias HrManagement.Attendance.AttendanceRecord

  @doc """
  Returns the list of attendance_records.

  ## Examples

      iex> list_attendance_records()
      [%AttendanceRecord{}, ...]

  """
  def list_attendance_records do
    Repo.all(AttendanceRecord)
  end

  @doc """
  Gets a single attendance_record.

  Raises `Ecto.NoResultsError` if the Attendance record does not exist.

  ## Examples

      iex> get_attendance_record!(123)
      %AttendanceRecord{}

      iex> get_attendance_record!(456)
      ** (Ecto.NoResultsError)

  """
  def get_attendance_record!(id), do: Repo.get!(AttendanceRecord, id)

  @doc """
  Creates a attendance_record.

  ## Examples

      iex> create_attendance_record(%{field: value})
      {:ok, %AttendanceRecord{}}

      iex> create_attendance_record(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_attendance_record(attrs \\ %{}) do
    %AttendanceRecord{}
    |> AttendanceRecord.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a attendance_record.

  ## Examples

      iex> update_attendance_record(attendance_record, %{field: new_value})
      {:ok, %AttendanceRecord{}}

      iex> update_attendance_record(attendance_record, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_attendance_record(%AttendanceRecord{} = attendance_record, attrs) do
    attendance_record
    |> AttendanceRecord.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a attendance_record.

  ## Examples

      iex> delete_attendance_record(attendance_record)
      {:ok, %AttendanceRecord{}}

      iex> delete_attendance_record(attendance_record)
      {:error, %Ecto.Changeset{}}

  """
  def delete_attendance_record(%AttendanceRecord{} = attendance_record) do
    Repo.delete(attendance_record)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking attendance_record changes.

  ## Examples

      iex> change_attendance_record(attendance_record)
      %Ecto.Changeset{data: %AttendanceRecord{}}

  """
  def change_attendance_record(%AttendanceRecord{} = attendance_record, attrs \\ %{}) do
    AttendanceRecord.changeset(attendance_record, attrs)
  end
end
