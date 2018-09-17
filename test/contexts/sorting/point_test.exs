defmodule Algorithms.Sorting.PointTest do
  alias Algorithms.Sorting.{Point, Field}

  use Algorithms.ConnCase

  setup do
    field = Field.initialize(10, 4, 10, 10)
    {:ok, field: field}
  end

  describe "#initialize" do
    test "Initialize point with given coordinates" do
      x = :rand.uniform()
      y = :rand.uniform()
      assert %Point{x: ^x, y: ^y} = Point.initialize(x, y)
    end
  end

  describe "#random_for_field" do
    test "Initialize point with given coordinates", %{field: field} do
      %Field{width: max_x, height: max_y} = field
      %Point{x: x, y: y} = Point.random_for_field(field)
      assert x < max_x and y < max_y
      assert x > 0 and y > 0
    end
  end

  describe "#random_colinear_points_for_field" do
    test "Return four collinear points", %{field: field} do
      [p1, p2, p3, p4] = Point.random_colinear_points_for_field(field)

      slope12 = Point.slope_to(p1, p2)
      slope13 = Point.slope_to(p1, p3)
      slope14 = Point.slope_to(p1, p4)

      assert Float.ceil(slope12, 9) == Float.ceil(slope13, 9)
      assert Float.ceil(slope12, 9) == Float.ceil(slope14, 9)
    end
  end

  describe "#slope_to" do
    test "Return 0 if line between points is horizontal" do
      p1 = Point.initialize(1, 3)
      p2 = Point.initialize(3, 3)

      assert 0 == Point.slope_to(p1, p2)
    end

    test "Return right slope" do
      p1 = Point.initialize(1, 1)
      p2 = Point.initialize(3, 2)

      assert 0.5 == Point.slope_to(p1, p2)
    end

    test "Return :infinity if line between points is horizontal" do
      p1 = Point.initialize(3, 1)
      p2 = Point.initialize(3, 3)

      assert :infinity == Point.slope_to(p1, p2)
    end
  end
end
