defmodule Algorithms.PriorityQueue.FieldQueueTest do
  use Algorithms.ConnCase

  alias Algorithms.PriorityQueue.{Field, FieldQueue}

  describe "#priority_function" do
    test "Count priority right #1" do
      assert (-9) ==
               %Field{
                 game_field: [[1, 3, 2], [4, 5, 6], [7, 8, 0]],
                 width: 3,
                 height: 3
               }
               |> FieldQueue.priority_function()
    end

    test "Count priority right #2" do
      assert (-15) ==
               %Field{
                 game_field: [[8, 1, 3], [4, 0, 2], [7, 6, 5]],
                 width: 3,
                 height: 3
               }
               |> FieldQueue.priority_function()
    end
  end
end
