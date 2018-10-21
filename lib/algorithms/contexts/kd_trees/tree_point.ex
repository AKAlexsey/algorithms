defmodule Algorithms.KDTrees.TreePoint do
  @moduledoc """
  Describe primitive object for both brute force and efficient algorithm.
  """

  @type t :: %__MODULE__{}
  @vertical :v
  @horizontal :h

  defstruct x: nil, y: nil, direction: nil, left_branch: nil, right_branch: nil

  alias Algorithms.KDTrees.Rectangle

  @spec initialize(x :: float, y :: float) :: %__MODULE__{}
  def initialize(x, y) when is_float(x) and is_float(y) do
    %__MODULE__{x: x, y: y}
  end

  @spec empty_set() :: any()
  def empty_set(), do: %__MODULE__{}

  @spec insert(points_set :: any(), point :: PointClass.t()) :: any()
  def insert(%__MODULE__{direction: nil} = set, %__MODULE__{} = point),
    do: %{point | direction: @vertical}

  def insert(%__MODULE__{direction: @vertical, x: x} = set, %__MODULE__{x: p_x} = point) do
    cond do
      is_nil(set.right_branch) and p_x >= x ->
        %{set | right_branch: %{point | direction: @horizontal}}

      p_x >= x ->
        %{set | right_branch: insert(set.right_branch, point)}

      is_nil(set.left_branch) ->
        %{set | left_branch: %{point | direction: @horizontal}}

      true ->
        %{set | left_branch: insert(set.left_branch, point)}
    end
  end

  def insert(%__MODULE__{direction: @horizontal, y: y} = set, %__MODULE__{y: p_y} = point) do
    cond do
      is_nil(set.right_branch) and p_y >= y ->
        %{set | right_branch: %{point | direction: @vertical}}

      p_y >= y ->
        %{set | right_branch: insert(set.right_branch, point)}

      is_nil(set.left_branch) ->
        %{set | left_branch: %{point | direction: @vertical}}

      true ->
        %{set | left_branch: insert(set.left_branch, point)}
    end
  end

  @spec vertical :: atom
  def vertical, do: @vertical

  @spec horizontal :: atom
  def horizontal, do: @horizontal

  @spec directions :: list(atom)
  def directions, do: [@vertical, @horizontal]

  @spec contains(points_set :: any(), point :: PointClass.t()) :: boolean
  def contains(nil, %__MODULE__{x: x, y: y}), do: false
  def contains(%__MODULE__{direction: nil}, %__MODULE__{x: x, y: y}), do: false

  def contains(
        %__MODULE__{direction: @vertical, x: x, y: y} = set,
        %__MODULE__{x: p_x, y: p_y} = point
      ) do
    cond do
      p_x == x and p_y == y ->
        true

      is_nil(set.right_branch) and p_x >= x ->
        false

      p_x >= x ->
        contains(set.right_branch, point)

      is_nil(set.left_branch) ->
        false

      true ->
        contains(set.left_branch, point)
    end
  end

  def contains(
        %__MODULE__{direction: @horizontal, x: x, y: y} = set,
        %__MODULE__{x: p_x, y: p_y} = point
      ) do
    cond do
      p_x == x and p_y == y ->
        true

      is_nil(set.right_branch) and p_y >= y ->
        false

      p_y >= y ->
        contains(set.right_branch, point)

      is_nil(set.left_branch) ->
        false

      true ->
        contains(set.left_branch, point)
    end
  end

  @spec nearest(points_set :: any(), point :: PointClass.t()) :: list(PointClass.t()) | []
  def nearest(set, %__MODULE__{x: x1, y: y1}) when is_list(set) do
    #    set
    #    |> Enum.reduce({:infinite, []}, fn %{x: x2, y: y2} = point,
    #                                       {smalest_distance, closest_points} ->
    #      distance = :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
    #
    #      cond do
    #        distance < smalest_distance ->
    #          {distance, [point]}
    #
    #        Float.round(distance, 6) == Float.round(smalest_distance, 6) ->
    #          {distance, closest_points ++ [point]}
    #
    #        true ->
    #          {smalest_distance, closest_points}
    #      end
    #    end)
    #    |> (fn {_dist, point} -> point end).()
  end

  @spec range(points_set :: any(), rectangle :: Rectangle.t()) :: list(PointClass.t())
  def range(%__MODULE__{direction: nil}, %Rectangle{}), do: []

  def range(
        %__MODULE__{direction: @vertical, x: x, y: y} = set,
        %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy} = rectangle
      ) do
    range_iterate_through_tree(set, rectangle)
    |> List.flatten()
    |> Enum.reject(&is_nil/1)
  end

  defp range_iterate_through_tree(
         %__MODULE__{direction: @vertical, x: x, y: y} = set,
         %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy} = rectangle
       ) do
    [
      if(x >= minx and x <= maxx and y >= miny and y <= maxy, do: virgin_point(set), else: nil),
      check_branch(set.left_branch, rectangle),
      check_branch(set.right_branch, rectangle)
    ]
  end

  defp range_iterate_through_tree(%__MODULE__{direction: @horizontal, x: x, y: y} = set) do
  end

  def check_branch(nil, _), do: nil

  def check_branch(
        %__MODULE__{direction: @vertical, x: x, y: y} = set,
        %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy} = rectangle
      ) do
    case intersect(set) do
      :full ->

    end
  end

  def check_branch(
        %__MODULE__{direction: @horizontal, x: x, y: y} = set,
        %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy} = rectangle
      ) do

  end

  defp virgin_point(%__MODULE__{x: x, y: y}), do: %__MODULE__{x: x, y: y}

  defp intersect(
         %__MODULE__{direction: @vertical, x: x, y: y} = set,
         %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy} = rectangle
       ) do
  end

  defp intersect(
         %__MODULE__{direction: @horizontal, x: x, y: y} = set,
         %Rectangle{minx: minx, maxx: maxx, miny: miny, maxy: maxy} = rectangle
       ) do
  end
end
