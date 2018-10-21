defmodule Algorithms.KDTrees.Benchmark do
  @moduledoc false

  alias Algorithms.KDTrees.{Algorithm, Field, SimplePoint}

  def perform(points_count_array, type, times \\ 10) when is_list(points_count_array) do
    points_count_array
    |> Enum.map(&initialize_test_params/1)
    |> Enum.map(&initialize_tests(&1, type))
    |> Enum.flat_map(& &1)
    |> Enum.into(%{})
    |> Benchee.run(time: times, formatters: [Benchee.Formatters.Console])
  end

  defp initialize_test_params(count) do
    {count, Algorithm.initialize_field(SimplePoint, count)}
  end

  defp initialize_tests({count, {field, _p_for_contains}}, :insert) do
    [
      {"\t#{count} p. SimplePoint insert",
       fn ->
         Field.add_random_point(field)
       end}
    ]
  end

  defp initialize_tests({count, {field, p_for_contains}}, :contains) do
    [
      {"\t#{count} p. SimplePoint contains",
       fn ->
         Algorithm.contains(field, p_for_contains)
       end}
    ]
  end

  defp initialize_tests({count, {field, _p_for_contains}}, :nearest) do
    [
      {"\t#{count} p. SimplePoint nearest",
       fn ->
         Algorithm.nearest(field)
       end}
    ]
  end

  defp initialize_tests({count, {field, _p_for_contains}}, :range) do
    [
      {"\t#{count} p. SimplePoint range",
       fn ->
         Algorithm.range(field)
       end}
    ]
  end
end
