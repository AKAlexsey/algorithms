defmodule Algorithms.UnionFind.Benchmark do
  alias Algorithms.UnionFind.{Algorithm, Field}

  def perform(tests, times) do
    tests
    |> Enum.into(%{})
    |> Benchee.run(time: times, formatters: [Benchee.Formatters.Console])
  end

  def test1(field_sizes \\ nil, times \\ 10) do
    (field_sizes || sizes())
    |> Enum.map(&initialize_test_quick_union(&1))
    |> perform(times)
  end

  def test2(field_sizes \\ nil, times \\ 10) do
    (field_sizes || sizes())
    |> Enum.map(&initialize_test_op_quick_union(&1))
    |> perform(times)
  end

  defp sizes(), do: [30, 60, 120, 240, 480]

  defp initialize_test_quick_union(size) do
    field = Field.initialize_field_with_union(size, size, &Algorithm.quick_union/3)
    {"\t#{size}x#{size} grid connected", fn -> check_connected(field) end}
  end

  defp initialize_test_op_quick_union(size) do
    field = Field.initialize_field_with_union(size, size, &Algorithm.op_quick_union/3)
    {"\t#{size}x#{size} grid connected", fn -> check_connected(field) end}
  end

  defp check_connected(field) do
    {p1, p2} = Field.two_random_points(field)
    Algorithm.connected?(field, p1, p2)
  end
end
