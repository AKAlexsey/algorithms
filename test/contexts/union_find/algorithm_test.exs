defmodule Algorithms.UnionFind.ALgorithmTest do
  alias Algorithms.UnionFind.{Field, Algorithm}

  use Algorithms.ConnCase

  describe "#quick_union" do
    setup do
      field = Field.initialize(3, 3)
      {:ok, field: field}
    end

    test "Right actions move to right result", %{field: field} do
      new_field = Algorithm.quick_union(field, {0, 1}, {2, 0})
      assert %{field: [0, 1, 2, 2, 4, 5, 6, 7, 8]} = new_field

      new_field = Algorithm.quick_union(new_field, {2, 1}, {0, 2})
      assert %{field: [0, 1, 2, 2, 4, 6, 6, 7, 8]} = new_field

      new_field = Algorithm.quick_union(new_field, {2, 1}, {1, 1})
      assert %{field: [0, 1, 2, 2, 5, 6, 6, 7, 8]} = new_field

      refute Algorithm.connected?(new_field, {0, 1}, {2, 1})

      new_field = Algorithm.quick_union(new_field, {2, 1}, {0, 1})
      assert %{field: [0, 1, 2, 2, 5, 6, 2, 7, 8]} = new_field

      assert Algorithm.connected?(new_field, {0, 1}, {2, 1})
      refute Algorithm.connected?(new_field, {0, 1}, {2, 2})
    end
  end
end
