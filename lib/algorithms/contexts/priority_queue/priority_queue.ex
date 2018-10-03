defmodule Algorithms.PriorityQueue.PriorityQueue do
  @moduledoc """
  Template for creation priority queue. Alow to specify priority callback.
  """

  @type t :: %__MODULE__{}

  defstruct elements: [], trash: [], size: 0, max_priority: 0, min_priority: 0
  alias __MODULE__, as: QueueStructure

  defmacro __using__(_opts) do
    quote do
      @callback priority_function(any()) :: integer

      @spec initialize :: %QueueStructure{}
      def initialize do
        %QueueStructure{}
      end

      @spec insert(%QueueStructure{}, any()) :: %QueueStructure{}
      def insert(
            %QueueStructure{
              elements: elements,
              trash: trash,
              size: size,
              max_priority: max,
              min_priority: min
            } = queue,
            element
          ) do
        priority = priority_function(element)
        element_present = Enum.any?(elements, &(&1 == element))
        trash_present = Enum.any?(trash, &(&1 == element))

        {new_elements, new_max_priority, new_min_priority} =
          cond do
            element_present || trash_present ->
              {elements, max, min}

            priority > max ->
              {elements ++ [element], priority, min}

            priority < min ->
              {[element] ++ elements, max, priority}

            true ->
              {logarithmik_insert(elements, trash, element, priority, size), max, min}
          end

        %QueueStructure{
          elements: new_elements,
          size: length(new_elements),
          trash: trash,
          max_priority: new_max_priority,
          min_priority: new_min_priority
        }
      end

      defp logarithmik_insert(elements, trash, element, priority, size) do
        index = get_index(elements, priority, size - 1, Integer.floor_div(size, 2))

        elements
        |> List.insert_at(index, element)
      end

      defp get_index(elements, priority, max_index, index) do
        array_element_priority =
          elements
          |> Enum.at(index)
          |> priority_function()

        cond do
          array_element_priority == priority ->
            index

          max_index - index == 0 ->
            index

          array_element_priority < priority ->
            get_index(
              elements,
              priority,
              max_index,
              Integer.floor_div(max_index - index + 1, 2) + index
            )

          array_element_priority > priority ->
            get_index(elements, priority, index, Integer.floor_div(index, 2))
        end
      end

      @spec pop(%QueueStructure{}) :: {%QueueStructure{}, any()}
      def pop(
            queue = %{
              elements: elements,
              trash: trash,
              size: size,
              min_priority: min,
              max_priority: max
            }
          )
          when size > 0 do
        new_size = size - 1
        element = Enum.at(elements, new_size)

        {
          %QueueStructure{
            elements: Enum.take(elements, new_size),
            size: new_size,
            trash: trash ++ [element],
            min_priority: if(new_size == 0, do: 0, else: min),
            max_priority:
              cond do
                new_size == 0 -> 0
                new_size == 1 -> min
                true -> Enum.at(elements, new_size - 1) |> priority_function()
              end
          },
          element
        }
      end

      def pop(queue), do: {queue, nil}
    end
  end
end
