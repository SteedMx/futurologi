defmodule FromSpace.Router do
  use FromSpace.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :admin_browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug FromSpace.Plug.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FromSpace do
    pipe_through :browser # Use the default browser stack

    get "/admin/new", AuthController, :new
    post "/admin/register", AuthController, :register

    get "/admin/login", AuthController, :auth
    post "/admin/login", AuthController, :login
    get "/admin/logout", AuthController, :logout

    get "/", PageController, :index
    get "/:post_url", PostController, :show
    get "/tag/:tag", PostController, :show_by_tag
  end

  scope "/admin", FromSpace do
    pipe_through :admin_browser

    resources "/posts", PostController
    get "/editor", DashboardController, :editor
    get "/editor/:post_id", DashboardController, :editor
    get "/preview/:post_id", DashboardController, :preview
    get "/dashboard", DashboardController, :dashboard
  end

  scope "/api", FromSpace do
    pipe_through :api

    get "/posts", Api.PostController, :index
  end
end
