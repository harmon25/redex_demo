defmodule RedexDemoWeb.PageController do
  use RedexDemoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
