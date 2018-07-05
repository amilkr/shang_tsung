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
    pipe_through :browser

    get "/", ExecutionController, :index
    resources "/executions", ExecutionController, only: [:create, :delete]
    resources "/config_files", ConfigFileController, only: [:create]
  end
end
