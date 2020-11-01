defmodule RedexDemoWeb.RedexChannel do
   use Phoenix.Channel
   require Logger


   def join("__redex:" <> channel_id, message, socket) do
    Application.get_env(:redex, :test) |> IO.inspect()
    IO.inspect(channel_id, label: "Start / link store for")
    IO.inspect(message, label: "params?")
    # if the channel_id is also the token = this is a private store - if the channel id !== token it is a shared store.
    if channel_id == message["token"] do
      store_pid =
        Redex.start_store(Demo.Store, channel_id, %{channel_id: channel_id})
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
      # else

      #   extra_store_pid =
      #     Redex.start_store(Demo.Store, channel_id, %{channel_id: channel_id})
      #     |> case do
      #       {:ok, pid} ->
      #         IO.inspect(pid, label: "Store pid")
      #        pid
      #       {:error, {:already_started, pid}} ->
      #         IO.inspect(pid, label: "Store pid")
      #        pid
      #     end
      #     send(self(), {:after_join, store_pid})
      #     current_state = Redex.get_state(store_pid)
    end

  end

  # need to assign the joined socket to the store - if done in join - the socket state has not been updated and broadcasting fails
  def handle_info({:after_join, store_pid}, socket) do
    Demo.Store.update_context(store_pid, %{socket: socket})
    {:noreply, Phoenix.Socket.assign(socket, :store_pids,[ store_pid | socket.assign.store_pids || [] ])}
  end





  def handle_in("dispatch", %{"type" => action_type, "payload" => payload}, socket) do
    Redex.dispatch(socket.assigns.store_pid, {String.to_existing_atom(action_type), payload})
    {:noreply, socket}
  end

end
