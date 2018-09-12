defmodule Algorithms.Sorting.Utils do
  @moduledoc """
  Nuff said.
  Helper functions.
  """

  alias Algorithms.Sorting.Point

  def closest_fourth_dividable(number, max)
      when is_integer(number) and is_integer(max) and number <= max do
    case Integer.mod(number, 4) do
      0 -> number
      diff -> number - diff
    end
    |> (fn answer -> if(answer > max, do: answer - 4, else: answer) end).()
  end

  def closest_fourth_dividable(_number, _max), do: 0

  def points_collinear([p1, p2, p3, p4]) do
    slope12 = Point.slope_to(p1, p2)
    slope13 = Point.slope_to(p1, p3)
    slope14 = Point.slope_to(p1, p4)

    slope12 == slope13 and slope12 == slope14
  end

  def four_points(field, i1, i2, i3, i4) do
    [
      Enum.at(field, i1),
      Enum.at(field, i2),
      Enum.at(field, i3),
      Enum.at(field, i4)
    ]
  end
end
