defmodule Algorithms.Sorting.Field do
  @moduledoc """
  Representation of the field.

  It's purposes:

  1. Initialize field with given characteristics;
  2. Check if all collinear points are set.
  """

  alias Algorithms.Sorting.{Utils, Point}

  @type t :: %__MODULE__{}

  defstruct field: [], width: nil, height: nil, simple_points_number: nil, collinear_points_number: nil

  @spec initialize(integer, integer, integer, integer) :: %__MODULE__{}
  def initialize(simple_points_number \\ 100, collinear_points_number \\ 12, width \\ 10, height \\ 10) do
    %__MODULE__{
      width: width,
      height: height,
      simple_points_number: simple_points_number,
      collinear_points_number: collinear_points_number
    }
  end

  def initialize_test_field(simple_points_number \\ 100, collinear_points_ratio \\ 0.1, width \\ 10, height \\ 10) do
    collinear_points_number = calculate_collinear_points(simple_points_number, collinear_points_ratio)
    initialize(simple_points_number, collinear_points_number, width, height)
    |> generate_points()
  end

  defp calculate_collinear_points(simple_points_number, collinear_points_ratio) do
    (simple_points_number * collinear_points_ratio)
    |> Kernel.trunc()
    |> Utils.closest_fourth_dividable(simple_points_number)
  end

  defp generate_points(%__MODULE__{} = field) do
    %{
      simple_points_number: simple_points_number,
      collinear_points_number: collinear_points_number
    } = field

    collinear_points = Kernel.trunc(collinear_points_number / 4)
    |> array_with_n_elems(fn _n -> Point.random_colinear_points_for_field(field) end)
    |> Enum.flat_map(&(&1))

    simple_points = (simple_points_number - collinear_points_number)
    |> array_with_n_elems(fn _n -> Point.random_for_field(field) end)


    {
      :ok,
      Map.put(field, :field, Enum.shuffle(simple_points ++ collinear_points)),
      collinear_points
    }
  end

  defp array_with_n_elems(n, element_function) do
    case n do
      0 -> []
      number ->
        (1..number)
        |> Enum.map(&element_function.(&1))
    end
  end
end
