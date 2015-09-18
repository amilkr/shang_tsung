defmodule ShangTsung.Router do
  use ShangTsung.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ShangTsung do
    pipe_through :browser # Use the default browser stack

    get "/", ExecutionController, :index
    post "/", ExecutionController, :start
    post "/configs", ConfigController, :new
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShangTsung do
  #   pipe_through :api
  # end
end
