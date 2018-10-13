defmodule Algorithms.KDTrees.SimplePoint do
  @moduledoc """
  Describe primitive object for both brute force and efficient algorithm.
  """

  defstruct x: nil, y: nil

  @spec insert(points_set :: any(), point :: PointClass.t()) :: any()
  @spec contains(points_set :: any(), point :: PointClass.t()) :: boolean
  @spec nearest(points_set :: any(), point :: PointClass.t()) :: PointClass.t() | nil
  @spec range(points_set :: any(), rectangle :: Rectangle.t()) :: list(PointClass.t())
end
