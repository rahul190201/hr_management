defmodule HrManagement.PerformanceTest do
  use HrManagement.DataCase

  alias HrManagement.Performance

  describe "performance_reviews" do
    alias HrManagement.Performance.PerformanceReview

    import HrManagement.PerformanceFixtures

    @invalid_attrs %{review_date: nil, rating: nil, feedback: nil}

    test "list_performance_reviews/0 returns all performance_reviews" do
      performance_review = performance_review_fixture()
      assert Performance.list_performance_reviews() == [performance_review]
    end

    test "get_performance_review!/1 returns the performance_review with given id" do
      performance_review = performance_review_fixture()
      assert Performance.get_performance_review!(performance_review.id) == performance_review
    end

    test "create_performance_review/1 with valid data creates a performance_review" do
      valid_attrs = %{review_date: ~D[2024-02-28], rating: 42, feedback: "some feedback"}

      assert {:ok, %PerformanceReview{} = performance_review} = Performance.create_performance_review(valid_attrs)
      assert performance_review.review_date == ~D[2024-02-28]
      assert performance_review.rating == 42
      assert performance_review.feedback == "some feedback"
    end

    test "create_performance_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Performance.create_performance_review(@invalid_attrs)
    end

    test "update_performance_review/2 with valid data updates the performance_review" do
      performance_review = performance_review_fixture()
      update_attrs = %{review_date: ~D[2024-02-29], rating: 43, feedback: "some updated feedback"}

      assert {:ok, %PerformanceReview{} = performance_review} = Performance.update_performance_review(performance_review, update_attrs)
      assert performance_review.review_date == ~D[2024-02-29]
      assert performance_review.rating == 43
      assert performance_review.feedback == "some updated feedback"
    end

    test "update_performance_review/2 with invalid data returns error changeset" do
      performance_review = performance_review_fixture()
      assert {:error, %Ecto.Changeset{}} = Performance.update_performance_review(performance_review, @invalid_attrs)
      assert performance_review == Performance.get_performance_review!(performance_review.id)
    end

    test "delete_performance_review/1 deletes the performance_review" do
      performance_review = performance_review_fixture()
      assert {:ok, %PerformanceReview{}} = Performance.delete_performance_review(performance_review)
      assert_raise Ecto.NoResultsError, fn -> Performance.get_performance_review!(performance_review.id) end
    end

    test "change_performance_review/1 returns a performance_review changeset" do
      performance_review = performance_review_fixture()
      assert %Ecto.Changeset{} = Performance.change_performance_review(performance_review)
    end
  end
end
