defmodule Algorithms.KDTrees.Algorithm do
  @moduledoc false

  alias Algorithms.KDTrees.{Field, Rectangle}

  def initialize_field(point_module, points_count) when is_integer(points_count) do
    {maxx, maxy} = default_sizes()
    field = Field.initialize(maxx, maxy, point_module)
    points_for_contains_count = Float.floor(points_count / 5)
    |> Kernel.trunc()

    field = (1..(points_count - points_for_contains_count))
    |> Enum.reduce(field, fn _, acc_field ->
      Field.add_random_point(acc_field)
    end)

    {field, points_for_contains} = (1..points_for_contains_count)
                                   |> Enum.reduce({field, []}, fn _, {acc_field, points} ->
      {x, y} = Field.random_coordinates(acc_field)

      {
        Field.add_point(acc_field, x, y),
        points ++ [acc_field.point_module.initialize(x, y)]
      }
    end)
    {field, Enum.shuffle(points_for_contains)}
  end

  def contains(field, points_for_contains) do
    Field.contains(field, Enum.random(points_for_contains))
  end

  def nearest(field) do
    random_point = Field.random_point(field)
    Field.nearest(field, random_point)
  end

  def range(field) do
    rectangle = random_rectangle(field)
    Field.range(field, rectangle)
  end

  defp default_sizes(), do: {10, 10}

  defp random_rectangle(field = %{maxx: maxx, maxy: maxy}) do
    [minx, maxx] = order_couple(:rand.uniform() * maxx, :rand.uniform() * maxx)
    [miny, maxy] = order_couple(:rand.uniform() * maxy, :rand.uniform() * maxy)
    Rectangle.initialize(minx, maxx, miny, maxy)
  end

  defp order_couple(e1, e2), do: Enum.sort([e1, e2])
end
