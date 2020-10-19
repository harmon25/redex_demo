defmodule RedexDemoWeb.RedexChannel do
   use Phoenix.Channel
   require Logger

   def join("__redex:" <> username, message, socket) do
    IO.inspect(username, label: "Start / link store for")
    IO.inspect(message, label: "params?")

    store_pid =
      Redex.start_store(Demo.Store, username, %{username: username})
      |> case do
        {:ok, pid} ->
          IO.inspect(pid, label: "Store pid")
         pid
        {:error, {:already_started, pid}} ->
          IO.inspect(pid, label: "Store pid")
         pid
      end
      send(self(), {:after_join, store_pid})
      current_state = Redex.get_state(store_pid)
    {:ok, current_state, socket}
  end

  # need to assign the joined socket to the store - if done in join - the socket state has not been updated and broadcasting fails
  def handle_info({:after_join, store_pid}, socket) do
    Demo.Store.update_context(store_pid, %{socket: socket})
    {:noreply, Phoenix.Socket.assign(socket, :store_pid, store_pid)}
  end

  def handle_in("dispatch", %{"type" => action_type, "payload" => payload}, socket) do
    Redex.dispatch(socket.assigns.store_pid, {String.to_existing_atom(action_type), payload})
    {:noreply, socket}
  end

end
