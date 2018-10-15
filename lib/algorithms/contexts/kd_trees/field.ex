defmodule Algorithms.KDTrees.Field do
  @moduledoc """
  Describe game field. No matter what algorithm. Contains field parameters.
  Set of points. And point class. Those must contain API:

  @spec initialize(x :: float, y :: float) :: PointClass.t()
  @spec empty_set() :: any()
  @spec insert(set :: any(), point :: PointClass.t()) :: any()
  @spec contains(set :: any(), point :: PointClass.t()) :: boolean
  @spec nearest(set :: any(), point :: PointClass.t()) :: PointClass.t() | nil
  @spec range(set :: any(), rectangle :: Rectangle.t()) :: list(PointClass.t())

  this API will use in appropriate field operations.
  """

  @type t :: %__MODULE__{}

  defstruct maxx: nil, maxy: nil, set: nil, point_class: nil

  alias Algorithms.KDTrees.Rectangle

  def initialize(maxx, maxy, p_class) do
    %__MODULE__{
      maxx: maxx,
      maxy: maxy,
      set: p_class.empty_set(),
      point_class: p_class
    }
  end

  def add_random_point(%__MODULE__{
        maxx: maxx,
        maxy: maxy,
        set: set,
        point_class: p_class
      }) do
    point = p_class.initialize(:random.uniform() * maxx, :random.uniform() * maxy)

    %__MODULE__{
      maxx: maxx,
      maxy: maxy,
      set: p_class.insert(set, point),
      point_class: p_class
    }
  end

  def add_point(%__MODULE__{
                        maxx: maxx,
                        maxy: maxy,
                        set: set,
                        point_class: p_class
                      }, x, y) do
    if x >= 0 and x <= maxx and y >= 0 and y <= maxy do
      point = p_class.initialize(x, y)

      %__MODULE__{
        maxx: maxx,
        maxy: maxy,
        set: p_class.insert(set, point),
        point_class: p_class
      }
    else
      raise FunctionClauseError
    end
  end

  def contains(field = %{set: set, point_class: p_class}, point = %{__struct__: p_class}) do
    p_class.contains(set, point)
  end

  def nearest(field = %{set: set, point_class: p_class}, point = %{__struct__: p_class}) do
    p_class.nearest(set, point)
  end

  def range(field = %{set: set, point_class: p_class}, rectangle = %Rectangle{}) do
    p_class.range(set, rectangle)
  end
end
