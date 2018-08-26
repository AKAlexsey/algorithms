defmodule Algorithms.UnionFind.ALgorithmTest do
  alias Algorithms.UnionFind.{Field, Algorithm}

  use Algorithms.ConnCase

  describe "#initialize" do
    test "Initialize %Node{} struct with no linked fields" do
      assert %Field{
        field: [0, 1, 2, 3, 4, 5],
        width: 3,
        height: 2
      } = Algorithm.initialize(3, 2)
    end
  end
end
