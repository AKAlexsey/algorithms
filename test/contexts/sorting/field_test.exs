defmodule Algorithms.Sorting.FieldTest do
  alias Algorithms.Sorting.{Point, Field}

  use Algorithms.ConnCase

  describe "#initialize" do
    test "Initialize point with given coordinates" do
      assert %Field{
               width: 5,
               height: 5,
               simple_points_number: 33,
               collinear_points_number: 11,
               field: []
             } = Field.initialize(33, 11, 5, 5)
    end

    test "Initialize with default parameters" do
      assert %Field{
               width: 10,
               height: 10,
               simple_points_number: 100,
               collinear_points_number: 12,
               field: []
             } = Field.initialize()
    end
  end

  describe "#initialize_test_field" do
    setup do: {:ok, width: 5, height: 5}

    test "Initialize test field with given characteristics. #1", %{width: width, height: height} do
      points_number = 16
      {:ok, field, collinear_points} = Field.initialize_test_field(16, 0.9, width, height)

      assert %Field{
               width: 5,
               height: 5,
               simple_points_number: 16,
               collinear_points_number: 12,
               field: all_points
             } = field

      assert length(all_points) == points_number
      assert length(collinear_points) |> Integer.mod(4) == 0
      assert length(collinear_points) == 12
      assert Enum.all?(all_points, fn %Point{x: x, y: y} -> x < width and y < height end)

      assert Enum.chunk_every(collinear_points, 4)
             |> Enum.all?(fn [p1, p2, p3, p4] ->
               slope12 = Point.slope_to(p1, p2) |> Float.ceil(9)
               slope13 = Point.slope_to(p1, p3) |> Float.ceil(9)
               slope14 = Point.slope_to(p1, p4) |> Float.ceil(9)

               slope12 == slope13 and slope12 == slope14
             end)
    end

    test "Initialize test field with given characteristics. #2", %{width: width, height: height} do
      points_number = 16
      {:ok, field, collinear_points} = Field.initialize_test_field(16, 1, width, height)

      assert %Field{
               width: 5,
               height: 5,
               simple_points_number: 16,
               collinear_points_number: 16,
               field: all_points
             } = field

      assert length(all_points) == points_number
      assert length(collinear_points) |> Integer.mod(4) == 0
      assert length(collinear_points) == points_number
      assert Enum.all?(all_points, fn %Point{x: x, y: y} -> x < width and y < height end)

      assert Enum.chunk_every(collinear_points, 4)
             |> Enum.all?(fn [p1, p2, p3, p4] ->
               slope12 = Point.slope_to(p1, p2) |> Float.ceil(9)
               slope13 = Point.slope_to(p1, p3) |> Float.ceil(9)
               slope14 = Point.slope_to(p1, p4) |> Float.ceil(9)

               slope12 == slope13 and slope12 == slope14
             end)
    end

    test "Initialize test field with given characteristics. #3", %{width: width, height: height} do
      points_number = 15
      {:ok, field, collinear_points} = Field.initialize_test_field(15, 1, width, height)

      assert %Field{
               width: 5,
               height: 5,
               simple_points_number: 15,
               collinear_points_number: 12,
               field: all_points
             } = field

      assert length(all_points) == points_number
      assert length(collinear_points) |> Integer.mod(4) == 0
      assert length(collinear_points) == 12
      assert Enum.all?(all_points, fn %Point{x: x, y: y} -> x < width and y < height end)

      assert Enum.chunk_every(collinear_points, 4)
             |> Enum.all?(fn [p1, p2, p3, p4] ->
               slope12 = Point.slope_to(p1, p2) |> Float.ceil(9)
               slope13 = Point.slope_to(p1, p3) |> Float.ceil(9)
               slope14 = Point.slope_to(p1, p4) |> Float.ceil(9)

               slope12 == slope13 and slope12 == slope14
             end)
    end
  end
end
