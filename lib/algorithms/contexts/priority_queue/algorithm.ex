defmodule Algorithms.PriorityQueue.Algorithm do
  @moduledoc """
  Contains A* Algorithm for solving puzzle.
  """
  alias Algorithms.PriorityQueue.{FieldQueue, Field}

  def perform(field = %{width: w, height: h}) do
    FieldQueue.initialize()
    |> FieldQueue.insert(field)
    |> iterate(Field.initialize_standard_field(w, h), 0)
  end

  defp iterate(queue, standard_field, index) do
    {queue, game_field} = FieldQueue.pop(queue)

    if Field.solved?(game_field, standard_field) do
      {:ok, :solved, game_field, index}
    else
      new_queue =
        game_field
        |> Field.allowed_swap()
        |> Enum.reduce(queue, fn swap, acc ->
          FieldQueue.insert(acc, Field.swap(game_field, swap))
        end)

      IO.puts("!!! Iteration ##{index}\n\n---------\n")
      iterate(new_queue, standard_field, index + 1)
    end
  end
end
