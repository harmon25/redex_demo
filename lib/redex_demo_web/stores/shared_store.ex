defmodule Demo.SharedStore do
  use Redex.Store, root_reducer: Demo.Root,
    change_callback: {Demo.Store, :change_callback}

  def change_callback(old_state, new_state, store_context) do
    # do whatever you want after an action has been dispatched, like broadcast diffs

     case Jsonpatch.diff(old_state, new_state) do
      [] -> :ok
      diff -> Phoenix.Channel.broadcast!(store_context.socket, "diff", %{diff: Jsonpatch.Mapper.to_map(diff)})
     end
  end
end
