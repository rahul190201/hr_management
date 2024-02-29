defmodule HrManagementWeb.ExpenseClaimLiveTest do
  use HrManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import HrManagement.ExpenseFixtures

  @create_attrs %{status: "some status", description: "some description", claim_date: "2024-02-28", amount: "120.5"}
  @update_attrs %{status: "some updated status", description: "some updated description", claim_date: "2024-02-29", amount: "456.7"}
  @invalid_attrs %{status: nil, description: nil, claim_date: nil, amount: nil}

  defp create_expense_claim(_) do
    expense_claim = expense_claim_fixture()
    %{expense_claim: expense_claim}
  end

  describe "Index" do
    setup [:create_expense_claim]

    test "lists all expense_claims", %{conn: conn, expense_claim: expense_claim} do
      {:ok, _index_live, html} = live(conn, ~p"/expense_claims")

      assert html =~ "Listing Expense claims"
      assert html =~ expense_claim.status
    end

    test "saves new expense_claim", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/expense_claims")

      assert index_live |> element("a", "New Expense claim") |> render_click() =~
               "New Expense claim"

      assert_patch(index_live, ~p"/expense_claims/new")

      assert index_live
             |> form("#expense_claim-form", expense_claim: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#expense_claim-form", expense_claim: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/expense_claims")

      html = render(index_live)
      assert html =~ "Expense claim created successfully"
      assert html =~ "some status"
    end

    test "updates expense_claim in listing", %{conn: conn, expense_claim: expense_claim} do
      {:ok, index_live, _html} = live(conn, ~p"/expense_claims")

      assert index_live |> element("#expense_claims-#{expense_claim.id} a", "Edit") |> render_click() =~
               "Edit Expense claim"

      assert_patch(index_live, ~p"/expense_claims/#{expense_claim}/edit")

      assert index_live
             |> form("#expense_claim-form", expense_claim: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#expense_claim-form", expense_claim: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/expense_claims")

      html = render(index_live)
      assert html =~ "Expense claim updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes expense_claim in listing", %{conn: conn, expense_claim: expense_claim} do
      {:ok, index_live, _html} = live(conn, ~p"/expense_claims")

      assert index_live |> element("#expense_claims-#{expense_claim.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#expense_claims-#{expense_claim.id}")
    end
  end

  describe "Show" do
    setup [:create_expense_claim]

    test "displays expense_claim", %{conn: conn, expense_claim: expense_claim} do
      {:ok, _show_live, html} = live(conn, ~p"/expense_claims/#{expense_claim}")

      assert html =~ "Show Expense claim"
      assert html =~ expense_claim.status
    end

    test "updates expense_claim within modal", %{conn: conn, expense_claim: expense_claim} do
      {:ok, show_live, _html} = live(conn, ~p"/expense_claims/#{expense_claim}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Expense claim"

      assert_patch(show_live, ~p"/expense_claims/#{expense_claim}/show/edit")

      assert show_live
             |> form("#expense_claim-form", expense_claim: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#expense_claim-form", expense_claim: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/expense_claims/#{expense_claim}")

      html = render(show_live)
      assert html =~ "Expense claim updated successfully"
      assert html =~ "some updated status"
    end
  end
end
