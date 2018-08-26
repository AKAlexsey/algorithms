defmodule Algorithms.UnionFind.Algorithm do
  @moduledoc """
  Week 1. Part 1 Union Find. Emplemintation of the algorighm
  """

  alias Algorithms.UnionFind.Field

  def initialize(w, h \\ nil)
  def initialize(w, nil), do: initialize_field(w, w)
  def initialize(w, h), do: initialize_field(w, h)

  defp initialize_field(w, h) do
    %Field{
      field: Enum.map((0..(w * h - 1)), fn x -> x end),
      width: w,
      height: h
    }
  end
end
