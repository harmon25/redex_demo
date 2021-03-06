defmodule RedexDemoWeb.Router do
  use RedexDemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # this is for login page, and logging out.
  scope "/",  RedexDemoWeb do
    pipe_through :browser
    get "/login", LoginController, :index
    post "/login", LoginController, :login
    post "/logout", LoginController, :logout
  end

  # this is to server the react app at every other path - delegating the routing to the front end.
  scope "/", RedexDemoWeb do
    pipe_through :browser
    get "/*app", AppController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", RedexDemoWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RedexDemoWeb.Telemetry
    end
  end
end
