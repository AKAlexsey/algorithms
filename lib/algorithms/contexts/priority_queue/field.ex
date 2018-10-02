defmodule Algorithms.PriorityQueue.Field do
  @moduledoc """
  Represent gaming field functions.
  """

  @empty_field 0

  @type t :: %__MODULE__{}
  defstruct game_field: [], width: 3, height: 3

  @spec initialize(integer, integer) :: __MODULE__.t()
  def initialize(width \\ 3, height \\ 3) do
    %__MODULE__{
      game_field: initialize_standard_field(width, height),
      width: width,
      height: height
    }
  end

  def initialize_standard_field(width, height) do
    1..height
    |> Enum.reduce([], fn j, field ->
      field_row =
        1..width
        |> Enum.reduce([], fn i, row ->
          element =
            cond do
              i == width and j == height -> @empty_field
              true -> i + (j - 1) * width
            end

          row ++ [element]
        end)

      field ++ [field_row]
    end)
  end

  @spec swap(%__MODULE__{}, {integer, integer}) :: __MODULE__.t()
  def swap(%__MODULE__{} = field, swapping) do
    empty_tile = empty_tile_coordinate(field)

    value = get_value(field, swapping)

    field
    |> set_value(empty_tile, value)
    |> set_value(swapping, @empty_field)
  end

  defp get_value(%__MODULE__{game_field: game_field}, {x, y}) do
    game_field
    |> Enum.at(y)
    |> Enum.at(x)
  end

  defp set_value(%__MODULE__{game_field: game_field} = field, {x, y}, value) do
    new_game_field =
      game_field
      |> List.update_at(y, fn row ->
        row
        |> List.update_at(x, fn _val -> value end)
      end)

    field
    |> Map.put(:game_field, new_game_field)
  end

  @spec allowed_swap(%__MODULE__{}) :: list({integer, integer})
  def allowed_swap(%__MODULE__{width: w, height: h} = field_model) do
    {x, y} = empty_tile_coordinate(field_model)

    vertical_swap =
      cond do
        y == 0 -> [{x, 1}]
        y == h - 1 -> [{x, y - 1}]
        true -> [{x, y - 1}, {x, y + 1}]
      end

    horizontal_swap =
      cond do
        x == 0 -> [{1, y}]
        x == w - 1 -> [{x - 1, y}]
        true -> [{x - 1, y}, {x + 1, y}]
      end

    (vertical_swap ++ horizontal_swap)
    |> Enum.filter(fn {x, y} ->
      x >= 0 and y >= 0 and x < w and y < h
    end)
  end

  @spec allowed_swap(%__MODULE__{}) :: {integer, integer}
  def empty_tile_coordinate(%__MODULE__{game_field: field, width: width, height: height}) do
    0..(height - 1)
    |> Enum.reduce_while({}, fn j, result1 ->
      0..(width - 1)
      |> Enum.reduce_while({}, fn i, result2 ->
        field
        |> Enum.at(j)
        |> Enum.at(i)
        |> case do
          @empty_field -> {:halt, {i, j}}
          _value -> {:cont, result2}
        end
      end)
      |> case do
        {} -> {:cont, result1}
        {x, y} -> {:halt, {x, y}}
      end
    end)
  end

  @spec shuffle(%__MODULE__{}, integer) :: __MODULE__.t()
  def shuffle(%__MODULE__{} = field, rate) when rate > 0 and is_integer(rate) do
    allowed = allowed_swap(field)
    swapping = Enum.at(allowed, :rand.uniform(length(allowed)) - 1)

    field
    |> swap(swapping)
    |> shuffle(rate - 1)
  end

  def shuffle(%__MODULE__{} = field, 0), do: field

  def solved?(%__MODULE__{game_field: game_field}, standard_field)
      when game_field == standard_field do
    true
  end

  def solved?(_game_field, _standard_field), do: false
end
