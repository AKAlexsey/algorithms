defmodule Algorithms.KDTrees.SimplePoint do
  @moduledoc """
  Describe primitive object for both brute force and efficient algorithm.
  """

  @type t :: %__MODULE__{}

  defstruct x: nil, y: nil

  alias Algorithms.KDTrees.Rectangle

  @spec initialize(x :: float, y :: float) :: %__MODULE__{}
  def initialize(x, y) when is_float(x) and is_float(y) do
    %__MODULE__{x: x, y: y}
  end

  @spec empty_set() :: any()
  def empty_set(), do: []

  @spec insert(points_set :: any(), point :: PointClass.t()) :: any()
  def insert(set, %__MODULE__{} = point) when is_list(set), do: set ++ [point]

  @spec contains(points_set :: any(), point :: PointClass.t()) :: boolean
  def contains(set, %__MODULE__{x: x, y: y}) when is_list(set) do
    Enum.any?(set, &(&1.x == x and &1.y == y))
  end

  @spec nearest(points_set :: any(), point :: PointClass.t()) :: list(PointClass.t()) | []
  def nearest(set, %__MODULE__{x: x1, y: y1}) when is_list(set) do
    set
    |> Enum.reduce({:infinite, []}, fn %{x: x2, y: y2} = point,
                                       {smalest_distance, closest_points} ->
      distance = :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))

      cond do
        distance < smalest_distance ->
          {distance, [point]}

        Float.round(distance, 6) == Float.round(smalest_distance, 6) ->
          {distance, closest_points ++ [point]}

        true ->
          {smalest_distance, closest_points}
      end
    end)
    |> (fn {_dist, point} -> point end).()
  end

  @spec range(points_set :: any(), rectangle :: Rectangle.t()) :: list(PointClass.t())
  def range(set, %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy}) when is_list(set) do
    set
    |> Enum.reduce([], fn p, points_inside ->
      if p.x >= minx and p.x <= maxx and p.y >= miny and p.y <= maxy do
        points_inside ++ [p]
      else
        points_inside
      end
    end)
  end
end
