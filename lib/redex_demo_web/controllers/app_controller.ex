defmodule RedexDemoWeb.AppController do
  use RedexDemoWeb, :controller

  def index(conn, _params) do
    get_session(conn, :user)
    |> case do
      nil ->
        redirect(conn, to: "/login")

      username ->
        render(conn, "index.html", username: username)
    end
  end
end
