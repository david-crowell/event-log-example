defmodule StatefulWeb.Router do
  use StatefulWeb, :router

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

  scope "/", StatefulWeb do
    pipe_through :api

    get "/", PageController, :index
    resources "/orders", OrderController
  end

  # Other scopes may use custom stacks.
  # scope "/api", StatefulWeb do
  #   pipe_through :api
  # end
end
