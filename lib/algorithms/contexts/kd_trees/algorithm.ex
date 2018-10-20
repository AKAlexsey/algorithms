defmodule Algorithms.KDTrees.Algorithm do
  @moduledoc false

  alias ALgorithms.KDTrees.{Field, SimplePoint}

  def perform(point_module, points_count) do
    {maxx, maxy} = default_sizes()
    field = Field.initialize(maxx, maxy, point_module)
    points_for_contains_count = Float.floor(points_count / 5)

  end

  def default_sizes(), do: {10, 10}
end
