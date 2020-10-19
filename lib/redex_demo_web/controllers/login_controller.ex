defmodule RedexDemoWeb.LoginController do
  use RedexDemoWeb, :controller

  def login(conn, %{"username" => username}) do
    put_session(conn, :user, username)
    |> redirect(to: "/")
  end

  def index(conn, _params) do
    delete_session(conn, :user)
    |> render( "index.html")
  end
end
