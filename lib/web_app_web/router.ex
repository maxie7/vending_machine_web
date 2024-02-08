defmodule WebAppWeb.Router do
  use WebAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WebAppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WebAppWeb do
    pipe_through :browser

    live_session :default do
      live "/", PageLive.Products, :products
      live "/login", PageLive.LogIn, :log_in
      live "/sign-up", PageLive.SignUp, :sign_up
      # get "/", PageController, :home
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", WebAppWeb do
  #   pipe_through :api
  # end
end
