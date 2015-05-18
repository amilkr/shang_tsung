defmodule ShangTsung.Router do
  use ShangTsung.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShangTsung do
    pipe_through :browser # Use the default browser stack

    get "/", RunController, :index
    post "/", RunController, :init
  end

  socket "/ws", ShangTsung do
    channel "logs:*", LogsChannel
  end
  # Other scopes may use custom stacks.
  # scope "/api", ShangTsung do
  #   pipe_through :api
  # end
end