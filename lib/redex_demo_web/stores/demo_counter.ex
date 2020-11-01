defmodule Demo.Counter do
  use Redex.Reducer, types_output_path: "./"

  def default_state() do
    0
  end

  @spec action({:add, integer()}, any(), any()) :: map()
  def action({:add, number}, state, _context) do
    state + number
  end

  @spec action({:subtract, integer()}, any(), any()) :: map()
  def action({:subtract, number}, state, _context) do
    state - number
  end

  @spec action({:reset, nil}, any(), any()) :: map()
  def action({:reset, _}, _state, _context) do
    default_state()
  end

  # serialize callback can be used to retrieve rows from db or strip fields.
  # must be serializable as json.
  def serialize(state) do
    state
  end
end
