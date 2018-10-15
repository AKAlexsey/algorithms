defmodule Algorithms.KDTrees.Field do
  @moduledoc """
  Describe game field. No matter what algorithm. Contains field parameters.
  Set of points. And point class. Those must contain API:

  @spec initialize(x :: float, y :: float) :: PointClass.t()
  @spec insert(points_set :: any(), point :: PointClass.t()) :: any()
  @spec contains(points_set :: any(), point :: PointClass.t()) :: boolean
  @spec nearest(points_set :: any(), point :: PointClass.t()) :: PointClass.t() | nil
  @spec range(points_set :: any(), rectangle :: Rectangle.t()) :: list(PointClass.t())

  this API will use in appropriate field operations.
  """

  @type t :: %__MODULE__{}

  defstruct maxx: nil, maxy: nil, points_set: nil, point_class: nil


end
