defmodule Algorithms.PriorityQueue.FieldQueue do
  @moduledoc """
  Implementation of priority queue with Field as element. And apropriate priority_function
  """

  alias Algorithms.PriorityQueue.Field

  use Algorithms.PriorityQueue.PriorityQueue

  def priority_function(%Field{game_field: game_field, standard_field: standard_field}) do
    hamming_distance(game_field, standard_field) +
    manhattan_distance(game_field, standard_field)
  end

  defp hamming_distance(_game_field, _standard_field) do
    3
  end

  defp manhattan_distance(_game_field, _standard_field) do
    3
  end
end
