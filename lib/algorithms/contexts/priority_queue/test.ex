defmodule Algorithms.PriorityQueue.Test do
  @moduledoc false

  alias Algorithms.PriorityQueue.{Field, Algorithm}

  def perform do
    field()
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
end
