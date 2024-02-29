defmodule HrManagement.PerformanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HrManagement.Performance` context.
  """

  @doc """
  Generate a performance_review.
  """
  def performance_review_fixture(attrs \\ %{}) do
    {:ok, performance_review} =
      attrs
      |> Enum.into(%{
        feedback: "some feedback",
        rating: 42,
        review_date: ~D[2024-02-28]
      })
      |> HrManagement.Performance.create_performance_review()

    performance_review
  end
end
