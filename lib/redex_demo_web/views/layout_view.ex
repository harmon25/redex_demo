defmodule RedexDemoWeb.LayoutView do
  use RedexDemoWeb, :view

  def get_csrf_token() do
    Phoenix.Controller.get_csrf_token()
  end
end
