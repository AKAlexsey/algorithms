defmodule Algorithms.PriorityQueue.Benchmark do
  @moduledoc """
  Nuff said
  """

  alias Algorithms.PriorityQueue.{Field, Algorithm}

  def perform(params \\ [], times \\ 50)
  def perform([], times), do: perform(default_params(), times)
  def perform(params, times) do
    params
    |> initialize_test_data_v2(times)
    |> initialize_tests()
    |> Enum.into(%{})
    |> Benchee.run(time: times, formatters: [Benchee.Formatters.Console])
  end

  defp initialize_test_data_v1(params, times) do
    Enum.map(params, fn {w, h, sh_ratio} ->
      fields_array = Enum.map((1..times), fn i ->
        Field.initialize(w, h)
        |> Field.shuffle(sh_ratio)
      end)
      argument_function = fn -> Enum.at(fields_array, :rand.uniform(times) - 1) end
      {w, h, sh_ratio, argument_function}
    end)
  end

  defp initialize_test_data_v2(params, times) do
    Enum.map(params, fn {w, h, sh_ratio} ->
      argument_function = fn -> Field.initialize(w, h) |> Field.shuffle(sh_ratio) end
      {w, h, sh_ratio, argument_function}
    end)
  end

  defp initialize_tests(params) do
    Enum.map(params, fn {w, h, r, arg_f} ->
      {
        "\t#{w}x#{h} - ratio: #{r}",
        fn -> Algorithm.perform(arg_f.()) end
      }
    end)
  end

  defp default_params do
    [{3, 3, 20}, {3, 6, 20}, {6, 6, 20}, {6, 12, 20}, {12, 12, 20}, {12, 24, 20}, {24, 24, 20}]
  end
end
