defmodule Algorithms.PriorityQueue.Test do
  @moduledoc false

  alias Algorithms.PriorityQueue.{Field, Algorithm, FieldQueue}

  def perform(shuffle_ratio \\ nil)
  def perform(shuffle_ratio) do
    Field.initialize()
    |> Field.shuffle(shuffle_ratio)
    |> print_field_data()
    |> Algorithm.perform()
  end
  def perform(nil) do
    field()
    |> print_field_data()
    |> Algorithm.perform()
  end

  # shuffled 40 times
  defp field do
    %Field{
      game_field: [[4, 1, 2], [8, 0, 3], [7, 6, 5]],
      height: 3,
      width: 3
    }
  end

  defp print_field_data(field) do
    IO.puts("!!! field:\n #{inspect(field)}\n")
    IO.puts("priority: #{FieldQueue.priority_function(field)}\n")
    field
  end
end
