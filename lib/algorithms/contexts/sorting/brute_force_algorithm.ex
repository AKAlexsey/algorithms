defmodule Algorithms.Sorting.BruteForseAlgorithm do
  @moduledoc false

  alias Algorithms.Sorting.{Field, Utils}

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
            points = Utils.four_points(field, i1, i2, i3, i4)

            if Utils.points_collinear(points) do
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
end
