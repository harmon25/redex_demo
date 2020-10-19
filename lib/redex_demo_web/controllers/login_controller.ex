defmodule RedexDemoWeb.LoginController do
  use RedexDemoWeb, :controller

  def logout(conn, _) do
    delete_session(conn, :user)
    |> redirect(to: "/")
  end

  def login(conn, %{"username" => username}) do
    put_session(conn, :user, username)
    |> redirect(to: "/")
  end

  def index(conn, _params) do
    delete_session(conn, :user)
    |> render("index.html")
  end
end
