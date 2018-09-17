defmodule Algorithms.Sorting.Benchmark do
  @moduledoc """
  Nuff said.
  """

  alias Algorithms.Sorting.{Algorithm, BruteForseAlgorithm, Field}

  def perform(params \\ [], time \\ 10)
  def perform([], times), do: perform(default_params(), times)

  def perform(params, times) do
    params
    |> Enum.map(&initialize_test_pair/1)
    |> Enum.flat_map(& &1)
    |> Enum.into(%{})
    |> Benchee.run(time: times, formatters: [Benchee.Formatters.Console])
  end

  defp initialize_test_pair({points, collinear_ratio}) do
    {:ok, field, collinear_points} = Field.initialize_test_field(points, collinear_ratio)

    [
      {"\t #{points} p.\t #{collinear_ratio} brute force",
       fn -> collinear_points == BruteForseAlgorithm.perform(field) end},
      {"\t #{points} p.\t #{collinear_ratio} fast sort  ",
       fn -> collinear_points == Algorithm.perform(field) end}
    ]
  end

  defp default_params, do: [{10, 0.5}, {20, 0.5}, {40, 0.5}, {80, 0.5}, {80, 0.1}]
end
