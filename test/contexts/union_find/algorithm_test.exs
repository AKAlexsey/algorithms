defmodule Algorithms.UnionFind.ALgorithmTest do
  alias Algorithms.UnionFind.{Field, Algorithm}

  use Algorithms.ConnCase

  describe "#initialize" do
    test "Initialize %Node{} struct with no linked fields" do
      assert %Field{
        field: [0, 1, 2, 3, 4, 5]
      } = Algorithm.initialize(3, 2)
    end
  end

  describe "#link" do
    setup do
      field = Algorithm.initialize(3, 3)
      {:ok, field: field}
    end

    test "Right actions move to right result", %{field: field} do
      new_field = Algorithm.union(field, 3, 2)
      assert [0, 1, 2, 2, 4, 5, 6, 7, 8] = new_field.field

      new_field = Algorithm.union(new_field, 5, 6)
      assert [0, 1, 2, 2, 4, 6, 6, 7, 8] == new_field.field

      new_field = Algorithm.union(new_field, 5, 4)
      assert [0, 1, 2, 2, 5, 6, 6, 7, 8] == new_field.field

      refute Algorithm.connected?(new_field, 3, 5)

      new_field = Algorithm.union(new_field, 4, 3)
      assert [0, 1, 2, 2, 5, 6, 2, 7, 8] == new_field.field

      assert Algorithm.connected?(new_field, 3, 5)
      refute Algorithm.connected?(new_field, 3, 8)
    end
  end
end
