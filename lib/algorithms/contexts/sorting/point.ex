defmodule Algorithms.Sorting.Point do
  @moduledoc """
  Representation of point on the field
  """

  @type t :: %__MODULE__{}

  alias Algorithms.Sorting.Field

  defstruct x: nil, y: nil

  @spec initialize(x :: integer, y :: integer) :: __MODULE__.t()
  def initialize(x, y) do
    %__MODULE__{x: x, y: y}
  end

  @spec random_for_field(Field.t()) :: __MODULE__.t()
  def random_for_field(%Field{width: w, height: h}) do
    initialize(:random.uniform() * w, :random.uniform() * h)
  end

  @spec random_colinear_points_for_field(Field.t()) :: list(__MODULE__.t())
  def random_colinear_points_for_field(%Field{} = field) do
    first_point = random_for_field(field)
    fourth_point = different_point(field, first_point)

    second_point_distance = :random.uniform()
    third_point_distance = different_float(second_point_distance)

    [
      first_point,
      point_between(first_point, fourth_point, second_point_distance),
      point_between(first_point, fourth_point, third_point_distance),
      fourth_point
    ]
  end

  def slope_to(%__MODULE__{x: x1, y: y1}, %__MODULE__{x: x2, y: y2}) do
    case (x2 - x1) do
      0.0 -> :infinity
      0 -> :infinity
      dx ->
        Float.ceil(((y2 - y1) / dx), 9)
    end
  end

  def different_point(%Field{} = field, %__MODULE__{} = point) do
    different_item(fn -> random_for_field(field) end, point)
  end

  def different_float(integer) do
    different_item(fn -> :random.uniform() end, integer)
  end

  def point_between(%__MODULE__{x: x1, y: y1}, %__MODULE__{x: x2, y: y2}, distance) do
    initialize(
      x1 + (x2 - x1) * distance,
      y1 + (y2 - y1) * distance
    )
  end

  defp different_item(function, previous_item) do
    case function.() do
      ^previous_item -> different_item(function, previous_item)
      new_item -> new_item
    end
  end
end
