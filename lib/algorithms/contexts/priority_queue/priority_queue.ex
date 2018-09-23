defmodule Algorithms.PriorityQueue.PriorityQueue do
  @moduledoc """
  Template for creation priority queue. Alow to specify priority callback.
  """

  @type t :: %__MODULE__{}

  defstruct elements: [], size: 0, max_priority: 0, min_priority: 0
  alias __MODULE__, as: QueueStructure

  defmacro __using__(_opts) do
    quote do
      @callback priority_function(any()) :: integer

      @spec initialize :: %QueueStructure{}
      def initialize do
        %QueueStructure{}
      end

      @spec insert(%QueueStructure{}, any()) :: %QueueStructure{}
      def insert(%QueueStructure{elements: elements, size: size, max_priority: max, min_priority: min} = queue, element) do
        priority = priority_function(element)

        {new_elements, new_max_priority, new_min_priority} = cond do
          priority > max ->
            {elements ++ [element], priority, min}
          priority < min ->
            {[element] ++ elements, max, priority}
          true ->
            {logarithmik_insert(elements, element, priority, size), max, min}
        end

        %QueueStructure{
          elements: new_elements,
          size: size + 1,
          max_priority: new_max_priority,
          min_priority: new_min_priority,
        }
      end

      defp logarithmik_insert(elements, element, priority, size) do
        index = get_index(elements, priority, size - 1, Integer.floor_div(size, 2))

        elements
        |> List.insert_at(index, element)
      end

      defp get_index(elements, priority, max_index, index) do
        array_element_priority = elements
        |> Enum.at(index)
        |> priority_function()

        cond do
          array_element_priority == priority ->
            index
          max_index - index == 0 ->
            index
          array_element_priority < priority ->
            get_index(elements, priority, max_index, Integer.floor_div(max_index - index + 1, 2) + index)
          array_element_priority > priority ->
            get_index(elements, priority, index, Integer.floor_div(index, 2))
        end
      end
    end
  end
end
