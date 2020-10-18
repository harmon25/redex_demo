defmodule Demo.Root do
  use Redex.AggReducer,
  combine_reducers: %{counter: Demo.Counter}
end
