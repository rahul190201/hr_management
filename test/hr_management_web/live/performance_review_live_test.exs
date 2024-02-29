defmodule HrManagementWeb.PerformanceReviewLiveTest do
  use HrManagementWeb.ConnCase

  import Phoenix.LiveViewTest
  import HrManagement.PerformanceFixtures

  @create_attrs %{review_date: "2024-02-28", rating: 42, feedback: "some feedback"}
  @update_attrs %{review_date: "2024-02-29", rating: 43, feedback: "some updated feedback"}
  @invalid_attrs %{review_date: nil, rating: nil, feedback: nil}

  defp create_performance_review(_) do
    performance_review = performance_review_fixture()
    %{performance_review: performance_review}
  end

  describe "Index" do
    setup [:create_performance_review]

    test "lists all performance_reviews", %{conn: conn, performance_review: performance_review} do
      {:ok, _index_live, html} = live(conn, ~p"/performance_reviews")

      assert html =~ "Listing Performance reviews"
      assert html =~ performance_review.feedback
    end

    test "saves new performance_review", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/performance_reviews")

      assert index_live |> element("a", "New Performance review") |> render_click() =~
               "New Performance review"

      assert_patch(index_live, ~p"/performance_reviews/new")

      assert index_live
             |> form("#performance_review-form", performance_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#performance_review-form", performance_review: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/performance_reviews")

      html = render(index_live)
      assert html =~ "Performance review created successfully"
      assert html =~ "some feedback"
    end

    test "updates performance_review in listing", %{conn: conn, performance_review: performance_review} do
      {:ok, index_live, _html} = live(conn, ~p"/performance_reviews")

      assert index_live |> element("#performance_reviews-#{performance_review.id} a", "Edit") |> render_click() =~
               "Edit Performance review"

      assert_patch(index_live, ~p"/performance_reviews/#{performance_review}/edit")

      assert index_live
             |> form("#performance_review-form", performance_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#performance_review-form", performance_review: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/performance_reviews")

      html = render(index_live)
      assert html =~ "Performance review updated successfully"
      assert html =~ "some updated feedback"
    end

    test "deletes performance_review in listing", %{conn: conn, performance_review: performance_review} do
      {:ok, index_live, _html} = live(conn, ~p"/performance_reviews")

      assert index_live |> element("#performance_reviews-#{performance_review.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#performance_reviews-#{performance_review.id}")
    end
  end

  describe "Show" do
    setup [:create_performance_review]

    test "displays performance_review", %{conn: conn, performance_review: performance_review} do
      {:ok, _show_live, html} = live(conn, ~p"/performance_reviews/#{performance_review}")

      assert html =~ "Show Performance review"
      assert html =~ performance_review.feedback
    end

    test "updates performance_review within modal", %{conn: conn, performance_review: performance_review} do
      {:ok, show_live, _html} = live(conn, ~p"/performance_reviews/#{performance_review}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Performance review"

      assert_patch(show_live, ~p"/performance_reviews/#{performance_review}/show/edit")

      assert show_live
             |> form("#performance_review-form", performance_review: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#performance_review-form", performance_review: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/performance_reviews/#{performance_review}")

      html = render(show_live)
      assert html =~ "Performance review updated successfully"
      assert html =~ "some updated feedback"
    end
  end
end
