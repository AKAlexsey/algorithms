defmodule Algorithms.Sorting.Utils do
  @moduledoc """
  Nuff said.
  Helper functions.
  """

  def closest_fourth_dividable(number, max)
      when is_integer(number) and is_integer(max) and number <= max do
    case Integer.mod(number, 4) do
      0 -> number
      diff -> number - diff
    end
    |> (fn answer -> if(answer > max, do: answer - 4, else: answer) end).()
  end

  def closest_fourth_dividable(_number, _max), do: 0
end
