defmodule Algorithms.PriorityQueue.FieldTest do
  use Algorithms.ConnCase

  alias Algorithms.PriorityQueue.Field

  describe "#initialize" do
    test "Initialize 3x3 standard field if no paramteters given" do
      assert %Field{
               game_field: [[1, 2, 3], [4, 5, 6], [7, 8, 0]],
               width: 3,
               height: 3
             } = Field.initialize()
    end

    test "Initialize field with given attributes" do
      assert %Field{
               game_field: [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 0]],
               width: 4,
               height: 3
             } = Field.initialize(4, 3)
    end
  end

  describe "#swap" do
    test "Get right swaps if empty point in corner #1" do
      field = %Field{
        game_field: [[1, 2, 3], [4, 5, 6], [7, 8, 0]],
        width: 3,
        height: 3
      }

      assert [{2, 1}, {1, 2}] = Field.allowed_swap(field)

      assert %{
               game_field: [[1, 2, 3], [4, 5, 0], [7, 8, 6]]
             } = Field.swap(field, {2, 1})

      assert %{
               game_field: [[1, 2, 3], [4, 5, 6], [7, 0, 8]]
             } = Field.swap(field, {1, 2})
    end
  end

  describe "#allowed_swap" do
    test "Get right swaps if empty point in corner #1" do
      field = %Field{
        game_field: [[1, 2, 3], [4, 5, 6], [7, 8, 0]],
        width: 3,
        height: 3
      }

      assert [{2, 1}, {1, 2}] = Field.allowed_swap(field)
    end

    test "Get right swaps if empty point in corner #2" do
      field = %Field{
        game_field: [[0, 2, 3], [1, 5, 6], [4, 7, 8]],
        width: 3,
        height: 3
      }

      assert [{0, 1}, {1, 0}] = Field.allowed_swap(field)
    end

    test "Get right swaps if empty point lie on edge #1" do
      field = %Field{
        game_field: [[2, 0, 3], [1, 5, 6], [4, 7, 8]],
        width: 3,
        height: 3
      }

      assert [{1, 1}, {0, 0}, {2, 0}] = Field.allowed_swap(field)
    end

    test "Get right swaps if empty point lie on edge #2" do
      field = %Field{
        game_field: [[1, 2, 0, 4], [5, 6, 3, 8], [9, 10, 7, 11]],
        width: 4,
        height: 3
      }

      assert [{2, 1}, {1, 0}, {3, 0}] = Field.allowed_swap(field)
    end

    test "Get right swaps if empty point in the middle of ield #1" do
      field = %Field{
        game_field: [[2, 0, 3], [1, 5, 6], [4, 7, 8]],
        width: 3,
        height: 3
      }

      assert [{1, 1}, {0, 0}, {2, 0}] = Field.allowed_swap(field)
    end

    test "Get right swaps if empty point in the middle of ield #2" do
      field = %Field{
        game_field: [[1, 2, 3, 4], [5, 6, 0, 8], [9, 10, 7, 11]],
        width: 4,
        height: 3
      }

      assert [{2, 0}, {2, 2}, {1, 1}, {3, 1}] = Field.allowed_swap(field)
    end

    test "Get right swaps even in one dimensional field #1" do
      field = %Field{
        game_field: [[1, 2, 3, 0]],
        width: 4,
        height: 1
      }

      assert [{2, 0}] = Field.allowed_swap(field)
    end

    test "Get right swaps even in one dimensional field #2" do
      field = %Field{
        game_field: [[1], [0], [2], [3]],
        width: 1,
        height: 4
      }

      assert [{0, 0}, {0, 2}] = Field.allowed_swap(field)
    end
  end

  describe "#empty_tile_coordinate" do
    test "Return right coordinate #1" do
      field = %Field{
        game_field: [[1, 2, 3], [4, 5, 6], [7, 8, 0]],
        width: 3,
        height: 3
      }

      assert {2, 2} = Field.empty_tile_coordinate(field)
    end

    test "Return right coordinate #2 use game field" do
      field = %Field{
        game_field: [[1, 2, 3], [0, 5, 6], [4, 7, 8]],
        width: 3,
        height: 3
      }

      assert {0, 1} = Field.empty_tile_coordinate(field)
    end

    test "Return right coordinate #3 for not standard size" do
      field = %Field{
        game_field: [[1, 2, 0, 4], [5, 6, 3, 8], [9, 10, 7, 11]],
        width: 3,
        height: 3
      }

      assert {2, 0} = Field.empty_tile_coordinate(field)
    end
  end
end
