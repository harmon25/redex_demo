defmodule Demo.Counter do
  use Redex.Reducer

  def default_state() do
    0
  end

  def action({:add, number}, state, _context) do
    state + number
  end

  def action({:subtract, number}, state, _context) do
    state - number
  end

  def action({:reset, _}, _state, _context) do
    default_state()
  end

  # serialize callback can be used to retrieve rows from db or strip fields.
  # must be serializable as json.
  def serialize(state) do
    state
  end
end
