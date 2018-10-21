defmodule Algorithms.KDTrees.Field do
  @moduledoc """
  Describe game field. No matter what algorithm. Contains field parameters.
  Set of points. And point module. Those must contain API:

  @spec initialize(x :: float, y :: float) :: PointClass.t()
  @spec empty_set() :: any()
  @spec insert(set :: any(), point :: PointClass.t()) :: any()
  @spec contains(set :: any(), point :: PointClass.t()) :: boolean
  @spec nearest(set :: any(), point :: PointClass.t()) :: PointClass.t() | nil
  @spec range(set :: any(), rectangle :: Rectangle.t()) :: list(PointClass.t())

  this API will use in appropriate field operations.
  """

  @type t :: %__MODULE__{}

  defstruct maxx: nil, maxy: nil, set: nil, point_module: nil

  alias Algorithms.KDTrees.Rectangle

  # TODO make polymorphism by protocols for different point modules
  def initialize(maxx, maxy, p_module) do
    %__MODULE__{
      maxx: maxx,
      maxy: maxy,
      set: p_module.empty_set(),
      point_module: p_module
    }
  end

  def add_random_point(%__MODULE__{point_module: p_module, set: set} = field) do
    point = random_point(field)

    %{field | set: p_module.insert(set, point)}
  end

  def random_point(%__MODULE__{point_module: p_module} = field) do
    {x, y} = random_coordinates(field)
    p_module.initialize(x, y)
  end

  def random_coordinates(%__MODULE__{maxx: maxx, maxy: maxy}) do
    {:random.uniform() * maxx, :random.uniform() * maxy}
  end

  def add_point(%__MODULE__{
                        maxx: maxx,
                        maxy: maxy,
                        set: set,
                        point_module: p_module
                      }, x, y) do
    if x >= 0 and x <= maxx and y >= 0 and y <= maxy do
      point = p_module.initialize(x, y)

      %__MODULE__{
        maxx: maxx,
        maxy: maxy,
        set: p_module.insert(set, point),
        point_module: p_module
      }
    else
      raise FunctionClauseError
    end
  end

  def contains(field = %{set: set, point_module: p_module}, point = %{__struct__: p_module}) do
    p_module.contains(set, point)
  end

  def nearest(field = %{set: set, point_module: p_module}, point = %{__struct__: p_module}) do
    p_module.nearest(set, point)
  end

  def range(field = %{set: set, point_module: p_module}, rectangle = %Rectangle{}) do
    p_module.range(set, rectangle)
  end
end
