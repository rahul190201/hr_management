defmodule HrManagement.LeaveTest do
  use HrManagement.DataCase

  alias HrManagement.Leave

  describe "leave_requests" do
    alias HrManagement.Leave.LeaveRequest

    import HrManagement.LeaveFixtures

    @invalid_attrs %{status: nil, start_date: nil, end_date: nil}

    test "list_leave_requests/0 returns all leave_requests" do
      leave_request = leave_request_fixture()
      assert Leave.list_leave_requests() == [leave_request]
    end

    test "get_leave_request!/1 returns the leave_request with given id" do
      leave_request = leave_request_fixture()
      assert Leave.get_leave_request!(leave_request.id) == leave_request
    end

    test "create_leave_request/1 with valid data creates a leave_request" do
      valid_attrs = %{status: "some status", start_date: ~D[2024-02-28], end_date: ~D[2024-02-28]}

      assert {:ok, %LeaveRequest{} = leave_request} = Leave.create_leave_request(valid_attrs)
      assert leave_request.status == "some status"
      assert leave_request.start_date == ~D[2024-02-28]
      assert leave_request.end_date == ~D[2024-02-28]
    end

    test "create_leave_request/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Leave.create_leave_request(@invalid_attrs)
    end

    test "update_leave_request/2 with valid data updates the leave_request" do
      leave_request = leave_request_fixture()
      update_attrs = %{status: "some updated status", start_date: ~D[2024-02-29], end_date: ~D[2024-02-29]}

      assert {:ok, %LeaveRequest{} = leave_request} = Leave.update_leave_request(leave_request, update_attrs)
      assert leave_request.status == "some updated status"
      assert leave_request.start_date == ~D[2024-02-29]
      assert leave_request.end_date == ~D[2024-02-29]
    end

    test "update_leave_request/2 with invalid data returns error changeset" do
      leave_request = leave_request_fixture()
      assert {:error, %Ecto.Changeset{}} = Leave.update_leave_request(leave_request, @invalid_attrs)
      assert leave_request == Leave.get_leave_request!(leave_request.id)
    end

    test "delete_leave_request/1 deletes the leave_request" do
      leave_request = leave_request_fixture()
      assert {:ok, %LeaveRequest{}} = Leave.delete_leave_request(leave_request)
      assert_raise Ecto.NoResultsError, fn -> Leave.get_leave_request!(leave_request.id) end
    end

    test "change_leave_request/1 returns a leave_request changeset" do
      leave_request = leave_request_fixture()
      assert %Ecto.Changeset{} = Leave.change_leave_request(leave_request)
    end
  end
end
