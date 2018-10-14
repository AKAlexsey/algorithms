defmodule Algorithms.KDTrees.Rectangle do
  @moduledoc """
  Describe primitive object for both brute force and efficient algorithm.
  """

  @type t :: %__MODULE__{}

  defstruct minx: nil, maxx: nil, miny: nil, maxy: nil
end
