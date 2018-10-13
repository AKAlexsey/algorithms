defmodule Algorithms.PriorityQueue.FieldQueue do
  @moduledoc """
  Implementation of priority queue with Field as element. And apropriate priority_function
  """

  alias Algorithms.PriorityQueue.Field

  use Algorithms.PriorityQueue.PriorityQueue

  def priority_function(%Field{game_field: game_field, width: width, height: height} = field) do
    standard_field = Field.initialize_standard_field(width, height)

    -1 *
      (hamming_distance(game_field, standard_field, width, height) +
         manhattan_distance(game_field, standard_field, width, height) +
         distance_to_search_tile(field))
  end

  defp hamming_distance(game_field, standard_field, width, height) do
    0..(height - 1)
    |> Enum.reduce(0, fn j, distance1 ->
      0..(width - 1)
      |> Enum.reduce(distance1, fn i, distance2 ->
        game_value = get_value(game_field, i, j)
        standard_value = get_value(standard_field, i, j)

        if(game_value != Field.empty_field() and game_value != standard_value) do
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

        if game_value == Field.empty_field() do
          distance2
        else
          {i1, j1} = find_indexes(game_value, standard_field, width, height)
          value_distance = abs(i - i1) + abs(j - j1)
          distance2 + value_distance
        end
      end)
    end)
  end

  defp distance_to_search_tile(%{width: width, height: height} = field) do
    {x, y} = Field.empty_tile_coordinate(field)

    near_points =
      -1..1
      |> Enum.reduce([], fn dx, acc1 ->
        -1..1
        |> Enum.reduce(acc1, fn dy, acc2 ->
          if(dx == 0 and dy == 0) do
            acc2
          else
            acc2 ++ [{x + dx, y + dy}]
          end
        end)
      end)

    near_points_count =
      near_points
      |> Enum.filter(fn {px, py} ->
        px >= 0 and px <= width - 1 and py >= 0 and py <= height - 1
      end)
      |> length()

    width * height - 1 - near_points_count
  end

  defp get_value(field, i, j) do
    field
    |> Enum.at(j)
    |> Enum.at(i)
  end

  defp find_indexes(value, standard_field, width, height) do
    0..(height - 1)
    |> Enum.reduce_while({}, fn j, _pair1 ->
      0..(width - 1)
      |> Enum.reduce_while({}, fn i, _pair12 ->
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
