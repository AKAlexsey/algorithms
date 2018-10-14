defmodule Algorithms.PriorityQueue.SimpleSimplePointTest do
  use Algorithms.ConnCase

  alias Algorithms.KDTrees.SimplePoint

  describe "#insert" do
    setup do
      set = [
        %SimplePoint{x: 0.3, y: 0.4},
        %SimplePoint{x: 0.2, y: 0.15},
        %SimplePoint{x: 0.33, y: 0.15}
      ]

      {:ok, set: set}
    end

    test "Add SimplePoint to the end of the list", %{set: set} do
      point = %SimplePoint{x: 0.23, y: 0.67}
      assert set ++ [point] == SimplePoint.insert(set, point)
    end

    test "Raise error if set is not list" do
      point = %SimplePoint{x: 0.23, y: 0.67}
      assert_raise FunctionClauseError, fn -> SimplePoint.insert(nil, point) end
    end

    test "Raise error if SimplePoint is no %SimplePoint{} structure", %{set: set} do
      assert_raise FunctionClauseError, fn -> SimplePoint.insert(set, %{x: 0.2, y: 0.2}) end
    end
  end

  describe "#contains" do
    setup do
      belong_point = %SimplePoint{x: 0.3, y: 0.4}
      set = [
        belong_point,
        %SimplePoint{x: 0.2, y: 0.15},
        %SimplePoint{x: 0.33, y: 0.15}
      ]

      {:ok, set: set, point: belong_point}
    end

    test "Return true if point belong to set", %{set: set, point: point} do
      assert SimplePoint.contains(set, point)
    end

    test "Return false if point does not belong to set", %{set: set} do
      point = %SimplePoint{x: 0.23, y: 0.67}
      refute SimplePoint.contains(set, point)
    end

    test "Raise error if set is not list" do
      point = %SimplePoint{x: 0.23, y: 0.67}
      assert_raise FunctionClauseError, fn -> SimplePoint.contains(nil, point) end
    end

    test "Raise error if SimplePoint is no %SimplePoint{} structure", %{set: set} do
      assert_raise FunctionClauseError, fn -> SimplePoint.contains(set, %{x: 0.2, y: 0.2}) end
    end
  end

  describe "#nearest" do
    setup do
      p1 = %SimplePoint{x: 0.3, y: 0.4}
      p2 = %SimplePoint{x: 0.1, y: 0.4}
      set = [p1, p2, %SimplePoint{x: 0.33, y: 0.15}]

      {:ok, set: set, p1: p1, p2: p2}
    end

    test "Return all nearest points #1", %{set: set, p1: p1} do
      result = SimplePoint.nearest(set, %SimplePoint{x: 0.3, y: 0.5})
      assert length(result) == 1
      assert Enum.any?(result, fn p -> p == p1 end)
    end

    test "Return all nearest points #1 if their count more than one", %{set: set, p1: p1, p2: p2} do
      result = SimplePoint.nearest(set, %SimplePoint{x: 0.2, y: 0.4})
      IO.inspect(result)
      assert length(result) == 2
      assert Enum.any?(result, fn p -> p == p1 end)
      assert Enum.any?(result, fn p -> p == p2 end)
    end

    test "Raise error if set is not list" do
      point = %SimplePoint{x: 0.23, y: 0.67}
      assert_raise FunctionClauseError, fn -> SimplePoint.nearest(nil, point) end
    end

    test "Raise error if SimplePoint is no %SimplePoint{} structure", %{set: set} do
      assert_raise FunctionClauseError, fn -> SimplePoint.nearest(set, %{x: 0.2, y: 0.2}) end
    end
  end

  describe "#range" do
  end
end
