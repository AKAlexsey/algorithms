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

  def connected?(%Field{} = field, p, q) do
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

  defp link(%Field{field: field, sizes: sizes} = field_struct, index1, index2) do
    sz1 = Enum.at(sizes, index1)
    sz2 = Enum.at(sizes, index2)
    field_struct
    |> Map.put(:field, List.update_at(field, index1, fn _ -> index2 end))
    |> Map.put(:sizes, List.update_at(sizes, index2, fn _ -> sz1 + sz2 end))
  end

  defp root(%Field{field: field} = field_struct, p) do
    iterate_throuth_array(field, Field.point_index(field_struct, p))
  end

  defp iterate_throuth_array(field, i) do
    parent_link = Enum.at(field, i)
    if(parent_link == i, do: i, else: iterate_throuth_array(field, parent_link))
  end

  def op_quick_union(%Field{} = field, p1, p2) do
    cond do
      Field.point_is_not_initialized?(field, p1) ->
        op_link_points(field, p1, p2)

      Field.point_is_not_initialized?(field, p2) ->
        op_link_points(field, p2, p1)

      true ->
        op_link_trees(field, p1, p2)
    end
  end

  defp op_link_points(%Field{} = field_struct, p1, p2) do
    op_link(field_struct, Field.point_index(field_struct, p1), Field.point_index(field_struct, p2))
  end

  defp op_link_trees(%Field{} = field_struct, p1, p2) do
    op_link(field_struct, root(field_struct, p1), root(field_struct, p2))
  end

  defp op_link(%Field{field: field, sizes: sizes} = field_struct, index1, index2) do
    sz1 = Enum.at(sizes, index1)
    sz2 = Enum.at(sizes, index2)
    if sz1 < sz2 do
      field_struct
      |> Map.put(:field, List.update_at(field, index1, fn _ -> index2 end))
      |> Map.put(:sizes, List.update_at(sizes, index2, fn _ -> sz1 + sz2 end))
    else
      field_struct
      |> Map.put(:field, List.update_at(field, index2, fn _ -> index1 end))
      |> Map.put(:sizes, List.update_at(sizes, index1, fn _ -> sz1 + sz2 end))
    end
  end
end
