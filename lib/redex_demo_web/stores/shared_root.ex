defmodule Demo.SharedRoot do
  use Redex.AggReducer,
  combine_reducers: %{shared_counter: Demo.SharedCounter}
end
