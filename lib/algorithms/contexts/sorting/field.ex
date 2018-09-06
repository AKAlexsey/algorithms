defmodule Algorithms.Sorting.Field do
  @moduledoc """
  Representation of the field.

  It's purposes:

  1. Initialize field with given characteristics;
  2. Check if all collinear points are set.
  """

  @type t :: %__MODULE__{}

  defstruct field: [], width: nil, height: nil, points_number: nil, collinear_points: nil, collinear_point_sets: []

  @spec initialize(integer, integer, integer, integer) :: %__MODULE__{}
  def initialize(points_number \\ 100, collinear_points \\ 10, width \\ 10, height \\ 10) do
    %__MODULE__{
      width: width,
      height: height,
      points_number: points_number,
      collinear_points: if(collinear_points > points_number, do: "", else: "")
    }
  end

  def initialize_test_field(points_number \\ 100, collinear_points \\ 10, width \\ 10, height \\ 10) do
    field = initialize(points_number, collinear_points, width, height)


  end
end
