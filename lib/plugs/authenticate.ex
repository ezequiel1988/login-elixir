defmodule MyAppWeb.Plugs.Authenticate do
  import Plug.Conn
  alias MyApp.Repo

  def init(default), do: default
  def call(conn, _default) do
    case MyApp.Services.Authenticator.get_auth_token(conn) do
      {:ok, token} ->
        case MyApp.Repo.get_by(MyApp.AuthToken, %{token: token, revoked: false}) |> Repo.preload(:user) do
          nil -> unauthorized(conn)
          auth_token -> authorized(conn, auth_token.user)
        end
      _ -> unauthorized(conn)
    end
  end
  defp authorized(conn, user) do
    # If you want, add new values to `conn`
    conn
    |> assign(:signed_in, true)
    |> assign(:signed_user, user)
  end
  defp unauthorized(conn) do
    conn |> send_resp(401, "Unauthorized") |> halt()
  end
end
