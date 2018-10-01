defmodule Algorithms.PriorityQueue.FieldQueue do
  @moduledoc """
  Implementation of priority queue with Field as element. And apropriate priority_function
  """

  alias Algorithms.PriorityQueue.Field

  use Algorithms.PriorityQueue.PriorityQueue

  def priority_function(%Field{game_field: game_field, width: width, height: height}) do
    standard_field = Field.initialize_standard_field(width, height)

    hamming_distance(game_field, standard_field, width, height) +
    manhattan_distance(game_field, standard_field, width, height)
  end

  defp hamming_distance(game_field, standard_field, width, height) do
    0..(height - 1)
    |> Enum.reduce(0, fn j, distance1 ->
      0..(width - 1)
      |> Enum.reduce(distance1, fn i, distance2 ->
        game_value = get_value(game_field, i, j)
        standard_value = get_value(standard_field, i, j)

        if(game_value != 0 and game_value != standard_value) do
          distance2 + 1
        else
          distance2
        end
      end)
    end)
  end

  defp manhattan_distance(game_field, standard_field, width, height) do
    0..(height - 1)
    |> Enum.reduce(0, fn j, distance1 ->
      0..(width - 1)
      |> Enum.reduce(distance1, fn i, distance2 ->
        game_value = get_value(game_field, i, j)
        if game_value == 0 do
          distance2
        else
          {i1, j1} = find_indexes(game_value, standard_field, width, height)
          value_distance = abs(i - i1) + abs(j - j1)
          distance2 + value_distance
        end
      end)
    end)
  end

  defp get_value(field, i, j) do
    field
    |> Enum.at(j)
    |> Enum.at(i)
  end

  defp find_indexes(value, standard_field, width, height) do
      0..(height - 1)
      |> Enum.reduce_while({}, fn j, pair1 ->
        result1 = 0..(width - 1)
        |> Enum.reduce_while({}, fn i, pair12 ->
          if(value == get_value(standard_field, i, j)) do
            {:halt, {i, j}}
          else
            {:cont, {}}
          end
        end)
        |> case do
          {x, y} -> {:halt, {x, y}}
          {} -> {:cont, {}}
        end
      end)
    end
end
