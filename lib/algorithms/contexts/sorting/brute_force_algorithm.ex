defmodule Algorithms.Sorting.BruteForseAlgorithm do
  @moduledoc """
  It's intentionally bad algorithm.
  My purpose is to compare bad and good algorithms.
  So please don't judge me :D
  """

  alias Algorithms.Sorting.{Field, Point}

  def perform(%Field{field: field}) when length(field) >= 4 do
    length = length(field)

    0..(length - 4)
    |> Enum.map(fn i1 ->
      (i1 + 1)..(length - 3)
      |> Enum.map(fn i2 ->
        (i2 + 1)..(length - 2)
        |> Enum.map(fn i3 ->
          (i3 + 1)..(length - 1)
          |> Enum.map(fn i4 ->
            points = four_points(field, i1, i2, i3, i4)

            if points_collinear(points) do
              points |> Enum.sort_by(fn %{x: x} -> x end)
            end
          end)
        end)
      end)
    end)
    |> Enum.flat_map(& &1)
    |> Enum.flat_map(& &1)
    |> Enum.flat_map(& &1)
    |> Enum.filter(fn elem -> ! is_nil(elem) end)
    |> Enum.flat_map(& &1)
    |> Enum.sort_by(fn %{x: x} -> x end)
  end

  def perform(%Field{field: _field}), do: []

  defp points_collinear([p1, p2, p3, p4]) do
    slope12 = Point.slope_to(p1, p2)
    slope13 = Point.slope_to(p1, p3)
    slope14 = Point.slope_to(p1, p4)

    slope12 == slope13 and slope12 == slope14
  end

  defp four_points(field, i1, i2, i3, i4) do
    [
      Enum.at(field, i1),
      Enum.at(field, i2),
      Enum.at(field, i3),
      Enum.at(field, i4)
    ]
  end
end
