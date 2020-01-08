defmodule MyAppWeb.SessionsView do
  use MyAppWeb, :view
  def render("show.json", auth_token) do
    %{data: %{token: auth_token.token}}
  end
end
