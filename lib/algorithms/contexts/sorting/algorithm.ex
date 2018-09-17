defmodule Algorithms.Sorting.Algorithm do
  @moduledoc """
  Algorithms with previous sorting of slopes.
  """

  alias Algorithms.Sorting.{Field, Point}

  def perform(%Field{field: field}) when length(field) >= 4 do
    length = length(field)

    sorted = Enum.sort_by(field, fn %{x: x} -> x end)

    0..(length - 4)
    |> Enum.map(fn i1 ->
      p1 = Enum.at(sorted, i1)
      (i1 + 1)..(length - 1)
      |> Enum.map(fn i2 ->
        p2 = Enum.at(sorted, i2)
        {p2, Point.slope_to(p1, p2)}
      end)
      |> Enum.sort_by(fn {_p, slope} -> slope end)
      |> Enum.chunk_every(3, 1, :discard)
      |> Enum.filter(&three_slopes_same/1)
      |> Enum.map(fn [{p2, _}, {p3, _}, {p4, _}] -> [p1, p2, p3, p4] end)
      |> Enum.flat_map(& &1)
    end)
    |> Enum.flat_map(& &1)
    |> Enum.sort_by(fn %{x: x} -> x end)
  end

  def perform(%Field{field: _field}), do: []

  defp three_slopes_same([{_, s1}, {_, s2}, {_, s3}]) do
    s1 == s2 and s1 == s3
  end
end
