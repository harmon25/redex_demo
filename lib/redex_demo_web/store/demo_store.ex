defmodule Demo.Store do
  use Redex.Store, root_reducer: Demo.Root,
    change_callback: {Demo.Store, :change_callback}

  def change_callback(_old_state, _new_state, _store_context) do
    # do whatever you want after an action has been dispatched, like broadcast diffs
    # diff = Diff.run(old_state, new_state)
    # broadcast!(store_context.socket, %{diff: diff})
  end
end
