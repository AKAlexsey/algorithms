defmodule Algorithms.Sorting.Point do
  @moduledoc """
  Representation of point on the field
  """

  @type t :: %__MODULE__{}

  alias Algorithms.Sorting.Field

  defstruct x: nil, y: nil

  @spec initialize_random() :: %__MODULE__{}
  def initialize_random(%Field{width: w, height: h}) do
    %__MODULE__{
      x: :random.uniform(w),
      y: :random.uniform(h),
    }
  end
end
