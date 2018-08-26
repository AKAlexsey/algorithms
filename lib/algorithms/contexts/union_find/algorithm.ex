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
      field: Enum.map((0..(w * h - 1)), fn x -> x end)
    }
  end

  def connected?(%Field{field: field}, p, q) do
    root(field, p) == root(field, q)
  end

  def union(%Field{field: field} = field_struct, p, q) do
    p_val = Enum.at(field, p)
    q_val = Enum.at(field, q)
    new_field = cond do
      p_val == p ->
        List.update_at(field, p, fn _ -> q end)
      q_val == q ->
        List.update_at(field, q, fn _ -> p end)
      true ->
        List.update_at(field, root(field, p), fn _ -> root(field, q) end)
    end

    Map.put(field_struct, :field, new_field)
  end

  def root(field, i) do
    iterate_throuth_array(field, i)
  end

  defp iterate_throuth_array(field, i) do
    parent_link = Enum.at(field, i)
    if(parent_link == i, do: i, else: iterate_throuth_array(field, parent_link))
  end
end
