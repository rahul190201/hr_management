defmodule HrManagementWeb.SalaryPayoutLiveTest do
  use HrManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import HrManagement.SalaryFixtures

  @create_attrs %{payout_date: "2024-02-28T04:06:00Z", amount: "120.5"}
  @update_attrs %{payout_date: "2024-02-29T04:06:00Z", amount: "456.7"}
  @invalid_attrs %{payout_date: nil, amount: nil}

  defp create_salary_payout(_) do
    salary_payout = salary_payout_fixture()
    %{salary_payout: salary_payout}
  end

  describe "Index" do
    setup [:create_salary_payout]

    test "lists all salary_payouts", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/salary_payouts")

      assert html =~ "Listing Salary payouts"
    end

    test "saves new salary_payout", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/salary_payouts")

      assert index_live |> element("a", "New Salary payout") |> render_click() =~
               "New Salary payout"

      assert_patch(index_live, ~p"/salary_payouts/new")

      assert index_live
             |> form("#salary_payout-form", salary_payout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#salary_payout-form", salary_payout: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/salary_payouts")

      html = render(index_live)
      assert html =~ "Salary payout created successfully"
    end

    test "updates salary_payout in listing", %{conn: conn, salary_payout: salary_payout} do
      {:ok, index_live, _html} = live(conn, ~p"/salary_payouts")

      assert index_live |> element("#salary_payouts-#{salary_payout.id} a", "Edit") |> render_click() =~
               "Edit Salary payout"

      assert_patch(index_live, ~p"/salary_payouts/#{salary_payout}/edit")

      assert index_live
             |> form("#salary_payout-form", salary_payout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#salary_payout-form", salary_payout: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/salary_payouts")

      html = render(index_live)
      assert html =~ "Salary payout updated successfully"
    end

    test "deletes salary_payout in listing", %{conn: conn, salary_payout: salary_payout} do
      {:ok, index_live, _html} = live(conn, ~p"/salary_payouts")

      assert index_live |> element("#salary_payouts-#{salary_payout.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#salary_payouts-#{salary_payout.id}")
    end
  end

  describe "Show" do
    setup [:create_salary_payout]

    test "displays salary_payout", %{conn: conn, salary_payout: salary_payout} do
      {:ok, _show_live, html} = live(conn, ~p"/salary_payouts/#{salary_payout}")

      assert html =~ "Show Salary payout"
    end

    test "updates salary_payout within modal", %{conn: conn, salary_payout: salary_payout} do
      {:ok, show_live, _html} = live(conn, ~p"/salary_payouts/#{salary_payout}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Salary payout"

      assert_patch(show_live, ~p"/salary_payouts/#{salary_payout}/show/edit")

      assert show_live
             |> form("#salary_payout-form", salary_payout: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#salary_payout-form", salary_payout: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/salary_payouts/#{salary_payout}")

      html = render(show_live)
      assert html =~ "Salary payout updated successfully"
    end
  end
end
