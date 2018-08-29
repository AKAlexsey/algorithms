defmodule Algorithms.UnionFind.Field do
  @moduledoc """
  Represents field.
  """

  alias Algorithms.UnionFind.Field

  defstruct field: [], width: nil, height: nil

  def initialize(w, h \\ nil)
  def initialize(w, nil), do: initialize_field(w, w)
  def initialize(w, h), do: initialize_field(w, h)

  defp initialize_field(w, h) do
    %__MODULE__{
      field: Enum.map((0..(w * h - 1)), fn x -> x end),
      width: w,
      height: h
    }
  end

  def initialize_field_with_union(width, height, union_function, coefficient \\ 0.4) do
    IO.puts("Initialize field for #{width}x#{height} QuickUnion")
    field_structure = initialize(width, height)

    coefficient = if(coefficient > 0.8, do: 0.8, else: coefficient)

    initialized_field = (1..(Kernel.trunc(width * height * coefficient)))
    |> Enum.to_list()
    |> Enum.reduce(field_structure, fn _i, field ->
      {first, second} = two_random_points(field)
      union_function.(field, first, second)
    end)
    IO.puts("Field has been initialized")
    initialized_field
  end

  def point_value(%__MODULE__{field: field} = field_structure, {_x, _y} = point) do
    Enum.at(field, point_index(field_structure, point))
  end

  def point_index(%__MODULE__{field: field, width: w}, {x, y}) do
    y * w + x
  end

  def point_is_not_initialized?(%__MODULE__{} = field_structure, point) do
    point_value(field_structure, point) == point_index(field_structure, point)
  end

  def random_point(%__MODULE__{width: w, height: h}) do
    {
      :rand.uniform(w) - 1,
      :rand.uniform(h) - 1
    }
  end

  def two_random_points(%__MODULE{} = field_structure) do
    first = other_random_point(field_structure)
    {
      first,
      other_random_point(field_structure, first)
    }
  end

  defp other_random_point(field_structure, previous_point \\ nil) do
    case random_point(field_structure) do
      ^previous_point  ->
        other_random_point(field_structure, previous_point)
      new_point ->
        new_point
    end
  end
end
