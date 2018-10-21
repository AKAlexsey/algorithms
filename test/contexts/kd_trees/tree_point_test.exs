defmodule Algorithms.PriorityQueue.TreePointTest do
  use Algorithms.ConnCase

  alias Algorithms.KDTrees.{TreePoint, Rectangle}

  describe "#initialize" do
    test "Initialize new point with given coordinates" do
      x = 0.3
      y = 0.4
      assert %TreePoint{x: ^x, y: ^y} = TreePoint.initialize(x, y)
    end

    test "Raise rrror is x is not float" do
      x = 1
      y = 0.4
      assert_raise FunctionClauseError, fn -> TreePoint.initialize(x, y) end
    end

    test "Raise rrror is y is not float" do
      x = 0.4
      y = 1
      assert_raise FunctionClauseError, fn -> TreePoint.initialize(x, y) end
    end
  end

  describe "#insert" do
    setup do
      set = %TreePoint{
        x: 0.3,
        y: 0.4,
        direction: TreePoint.vertical(),
        left_branch: %TreePoint{
          x: 0.2,
          y: 0.15,
          direction: TreePoint.horizontal(),
          left_branch: nil,
          right_branch: nil
        },
        right_branch: %TreePoint{
          x: 0.33,
          y: 0.15,
          direction: TreePoint.horizontal(),
          left_branch: nil,
          right_branch: nil
        }
      }

      {:ok, set: set}
    end

    test "Add TreePoint to right child of left branch #1", %{set: set} do
      x = 0.23
      y = 0.67
      direction = TreePoint.vertical()
      point = %TreePoint{x: x, y: y}
      result = TreePoint.insert(set, point)
      assert %TreePoint{x: ^x, y: ^y, direction: ^direction} = result.left_branch.right_branch
    end

    test "Add TreePoint to right child of left branch #2", %{set: set} do
      x = 0.23
      y = 0.1
      direction = TreePoint.vertical()
      point = %TreePoint{x: x, y: y}
      result = TreePoint.insert(set, point)
      assert %TreePoint{x: ^x, y: ^y, direction: ^direction} = result.left_branch.left_branch
    end

    test "Add TreePoint to right child of left branch #3", %{set: set} do
      x = 0.4
      y = 0.05
      direction = TreePoint.vertical()
      point = %TreePoint{x: x, y: y}
      result = TreePoint.insert(set, point)
      assert %TreePoint{x: ^x, y: ^y, direction: ^direction} = result.right_branch.left_branch
    end

    test "Add TreePoint to right child of left branch #4", %{set: set} do
      x = 0.4
      y = 0.3
      direction = TreePoint.vertical()
      point = %TreePoint{x: x, y: y}
      result = TreePoint.insert(set, point)
      assert %TreePoint{x: ^x, y: ^y, direction: ^direction} = result.right_branch.right_branch
    end

    test "Raise error if set is not %TreePoint{} structure" do
      point = %TreePoint{x: 0.23, y: 0.67}
      assert_raise FunctionClauseError, fn -> TreePoint.insert(nil, point) end
    end

    test "Raise error if point is not %TreePoint{}", %{set: set} do
      assert_raise FunctionClauseError, fn -> TreePoint.insert(set, %{x: 0.2, y: 0.2}) end
    end
  end


  describe "#contains" do
    setup do
      belong_point = %TreePoint{x: 0.1, y: 0.4, direction: TreePoint.vertical()}
      set = %TreePoint{
        x: 0.3,
        y: 0.4,
        direction: TreePoint.vertical(),
        left_branch: %TreePoint{
          x: 0.2,
          y: 0.15,
          direction: TreePoint.horizontal(),
          left_branch: nil,
          right_branch: belong_point
        },
        right_branch: %TreePoint{
          x: 0.33,
          y: 0.15,
          direction: TreePoint.horizontal(),
          left_branch: nil,
          right_branch: nil
        }
      }

      {:ok, set: set, point: belong_point}
    end

    test "Return true if point belong to set", %{set: set, point: point} do
      assert TreePoint.contains(set, point)
    end

    test "Return false if point does not belong to set", %{set: set} do
      point = %TreePoint{x: 0.23, y: 0.67}
      refute TreePoint.contains(set, point)
    end

    test "Return false if set if nil" do
      point = %TreePoint{x: 0.23, y: 0.67}
      refute TreePoint.contains(nil, point)
    end

    test "Raise error if set is not %TreePoint{}" do
      point = %TreePoint{x: 0.23, y: 0.67}
      assert_raise FunctionClauseError, fn -> TreePoint.contains(%{}, point) end
    end

    test "Raise error if TreePoint is not %TreePoint{} structure", %{set: set} do
      assert_raise FunctionClauseError, fn -> TreePoint.contains(set, %{x: 0.2, y: 0.2}) end
    end
  end

#  describe "#nearest" do
#    setup do
#      p1 = %TreePoint{x: 0.3, y: 0.4}
#      p2 = %TreePoint{x: 0.1, y: 0.4}
#      set = [p1, p2, %TreePoint{x: 0.33, y: 0.15}]
#      set = %TreePoint{
#        x: 0.3,
#        y: 0.4,
#        direction: TreePoint.vertical(),
#        left_branch: %TreePoint{
#          x: 0.2,
#          y: 0.15,
#          direction: TreePoint.horizontal(),
#          left_branch: nil,
#          right_branch: belong_point
#        },
#        right_branch: %TreePoint{
#          x: 0.33,
#          y: 0.15,
#          direction: TreePoint.horizontal(),
#          left_branch: nil,
#          right_branch: nil
#        }
#      }
#
#      {:ok, set: set, p1: p1, p2: p2}
#    end
#
#    test "Return all nearest points #1", %{set: set, p1: p1} do
#      result = TreePoint.nearest(set, %TreePoint{x: 0.3, y: 0.5})
#      assert length(result) == 1
#      assert Enum.any?(result, fn p -> p == p1 end)
#    end
#
#    test "Return all nearest points #1 if their count more than one", %{set: set, p1: p1, p2: p2} do
#      result = TreePoint.nearest(set, %TreePoint{x: 0.2, y: 0.4})
#      assert length(result) == 2
#      assert Enum.any?(result, fn p -> p == p1 end)
#      assert Enum.any?(result, fn p -> p == p2 end)
#    end
#
#    test "Raise error if set is not list" do
#      point = %TreePoint{x: 0.23, y: 0.67}
#      assert_raise FunctionClauseError, fn -> TreePoint.nearest(nil, point) end
#    end
#
#    test "Raise error if TreePoint is no %TreePoint{} structure", %{set: set} do
#      assert_raise FunctionClauseError, fn -> TreePoint.nearest(set, %{x: 0.2, y: 0.2}) end
#    end
#  end

  describe "#range" do
    setup do
      p1 = %TreePoint{
        x: 0.3,
        y: 0.4,
        direction: TreePoint.vertical(),
        left_branch: nil,
        right_branch: nil
      }
      p2 = %TreePoint{
        x: 0.1,
        y: 0.4,
        direction: TreePoint.horizontal(),
        left_branch: nil,
        right_branch: nil
      }
      p3 = %TreePoint{
        x: 0.33,
        y: 0.15,
        direction: TreePoint.horizontal(),
        left_branch: nil,
        right_branch: nil
      }
      set = %{p1 | left_branch: p2, right_branch: p3}
      rectangle = %Rectangle{minx: 0.05, maxx: 0.31, miny: 0.3, maxy: 0.5}

      {:ok, set: set, p1: p1, p2: p2, rectangle: rectangle}
    end

    test "Return all range points those belong to rectangle", %{set: set, p1: p1, p2: p2, rectangle: r} do
      result = TreePoint.range(set, r)
      assert length(result) == 2
      assert Enum.any?(result, fn p -> p == p1 end)
      assert Enum.any?(result, fn p -> p == p2 end)
    end

#    test "Raise error if set is not list", %{rectangle: r} do
#      assert_raise FunctionClauseError, fn -> TreePoint.range(nil, r) end
#    end

    test "Raise error if rectangle is not %Rectangle{}", %{set: set} do
      assert_raise FunctionClauseError, fn -> TreePoint.range(set, %{x: 0.2, y: 0.2}) end
    end
  end
end
