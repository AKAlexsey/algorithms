defmodule Algorithms.UnionFind.Benchmark do
  alias Algorithms.UnionFind.Algorithm

  def perform(field_sizes \\ nil, times \\ 10) do
    flds = field_sizes || sizes()

    flds
    |> Enum.map(&initialize_test(&1))
    |> Enum.into(%{})
    |> Benchee.run(time: times)
  end

  defp sizes(), do: [30, 60, 120, 240, 480]

  defp initialize_test(size) do
    field = initialize_test_field(size)
    {"\t#{size}x#{size} grid connected", fn -> check_connected(field, size) end}
  end

  defp check_connected(field, size) do
    {p, q} = two_random_numbers(size * size)
    Algorithm.connected?(field, p, q)
  end

  defp initialize_test_field(size) do
    IO.puts("Initialize field for #{size}")
    field = Algorithm.initialize(size, size)

    initialized_field = (1..(Kernel.trunc(size * size / 4)))
    |> Enum.to_list()
    |> Enum.reduce(field, fn _i, field ->
      {first, second} = two_random_numbers(size * size)
      Algorithm.union(field, first, second)
    end)
    IO.puts("Field has been initialized")
    initialized_field
  end

  defp two_random_numbers(number) do
    first = other_random(number)
    {
      first,
      other_random(number, first)
    }
  end

  defp other_random(base, previous_number \\ nil) do
    case :rand.uniform(base) - 1 do
      ^previous_number  ->
        other_random(base, previous_number)
      new_number ->
        new_number
    end
  end
end
