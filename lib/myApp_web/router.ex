defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticate do
    plug MyAppWeb.Plugs.Authenticate
  end


  scope "/api", MyAppWeb do
    pipe_through :api
    resources "/users", UserController
  end

  scope "/sessions", MyAppWeb do
    post "/sign_in", SessionsController, :create
    delete "/sign_out", SessionsController, :delete
  end
end
