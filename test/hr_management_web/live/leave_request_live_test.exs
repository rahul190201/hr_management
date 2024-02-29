defmodule HrManagementWeb.LeaveRequestLiveTest do
  use HrManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import HrManagement.LeaveFixtures

  @create_attrs %{status: "some status", start_date: "2024-02-28", end_date: "2024-02-28"}
  @update_attrs %{status: "some updated status", start_date: "2024-02-29", end_date: "2024-02-29"}
  @invalid_attrs %{status: nil, start_date: nil, end_date: nil}

  defp create_leave_request(_) do
    leave_request = leave_request_fixture()
    %{leave_request: leave_request}
  end

  describe "Index" do
    setup [:create_leave_request]

    test "lists all leave_requests", %{conn: conn, leave_request: leave_request} do
      {:ok, _index_live, html} = live(conn, ~p"/leave_requests")

      assert html =~ "Listing Leave requests"
      assert html =~ leave_request.status
    end

    test "saves new leave_request", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/leave_requests")

      assert index_live |> element("a", "New Leave request") |> render_click() =~
               "New Leave request"

      assert_patch(index_live, ~p"/leave_requests/new")

      assert index_live
             |> form("#leave_request-form", leave_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#leave_request-form", leave_request: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/leave_requests")

      html = render(index_live)
      assert html =~ "Leave request created successfully"
      assert html =~ "some status"
    end

    test "updates leave_request in listing", %{conn: conn, leave_request: leave_request} do
      {:ok, index_live, _html} = live(conn, ~p"/leave_requests")

      assert index_live |> element("#leave_requests-#{leave_request.id} a", "Edit") |> render_click() =~
               "Edit Leave request"

      assert_patch(index_live, ~p"/leave_requests/#{leave_request}/edit")

      assert index_live
             |> form("#leave_request-form", leave_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#leave_request-form", leave_request: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/leave_requests")

      html = render(index_live)
      assert html =~ "Leave request updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes leave_request in listing", %{conn: conn, leave_request: leave_request} do
      {:ok, index_live, _html} = live(conn, ~p"/leave_requests")

      assert index_live |> element("#leave_requests-#{leave_request.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#leave_requests-#{leave_request.id}")
    end
  end

  describe "Show" do
    setup [:create_leave_request]

    test "displays leave_request", %{conn: conn, leave_request: leave_request} do
      {:ok, _show_live, html} = live(conn, ~p"/leave_requests/#{leave_request}")

      assert html =~ "Show Leave request"
      assert html =~ leave_request.status
    end

    test "updates leave_request within modal", %{conn: conn, leave_request: leave_request} do
      {:ok, show_live, _html} = live(conn, ~p"/leave_requests/#{leave_request}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Leave request"

      assert_patch(show_live, ~p"/leave_requests/#{leave_request}/show/edit")

      assert show_live
             |> form("#leave_request-form", leave_request: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#leave_request-form", leave_request: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/leave_requests/#{leave_request}")

      html = render(show_live)
      assert html =~ "Leave request updated successfully"
      assert html =~ "some updated status"
    end
  end
end
