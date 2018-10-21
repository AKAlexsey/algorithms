defmodule Algorithms.KDTrees.Rectangle do
  @moduledoc """
  Describe primitive object for both brute force and efficient algorithm.
  """

  @type t :: %__MODULE__{}

  defstruct minx: nil, maxx: nil, miny: nil, maxy: nil

  def initialize(minx, maxx, miny, maxy) do
    %__MODULE__{minx: minx, maxx: maxx, miny: miny, maxy: maxy}
  end
end
