defmodule ShangTsungWeb.Router do
  use ShangTsungWeb, :router

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

  scope "/", ShangTsungWeb do
    pipe_through :browser # Use the default browser stack

    get "/", ExecutionController, :index
    resources "/executions", ExecutionController, only: [:create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShangTsungWeb do
  #   pipe_through :api
  # end
end
