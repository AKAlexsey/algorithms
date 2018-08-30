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
      field: Enum.map(0..(w * h - 1), fn x -> x end)
    }
  end

  def connected?(%Field{field: field}, p, q) do
    root(field, p) == root(field, q)
  end

  def quick_union(%Field{} = field, p1, p2) do
    cond do
      Field.point_is_not_initialized?(field, p1) ->
        link_points(field, p1, p2)

      Field.point_is_not_initialized?(field, p2) ->
        link_points(field, p2, p1)

      true ->
        link_trees(field, p1, p2)
    end
  end

  defp link_points(%Field{} = field_struct, p1, p2) do
    link(field_struct, Field.point_index(field_struct, p1), Field.point_index(field_struct, p2))
  end

  defp link_trees(%Field{} = field_struct, p1, p2) do
    link(field_struct, root(field_struct, p1), root(field_struct, p2))
  end

  defp link(%Field{field: field} = field_struct, index1, index2) do
    Map.put(
      field_struct,
      :field,
      List.update_at(field, index1, fn _ -> index2 end)
    )
  end

  defp root(%Field{field: field} = field_struct, p) do
    iterate_throuth_array(field, Field.point_index(field_struct, p))
  end

  defp iterate_throuth_array(field, i) do
    parent_link = Enum.at(field, i)
    if(parent_link == i, do: i, else: iterate_throuth_array(field, parent_link))
  end
end
