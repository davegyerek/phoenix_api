defmodule PhoenixApiWeb.SessionController do
  use PhoenixApiWeb, :controller

  alias PhoenixApi.Auth

  action_fallback(PhoenixApiWeb.FallbackController)

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Auth.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> put_status(:ok)
        |> render(PhoenixApiWeb.SessionView, "sign_in.json", user: user)

      {:error, message} ->
        conn
        |> delete_session(:current_user_id)
        |> put_status(:unauthorized)
        |> render(PhoenixApiWeb.ErrorView, "401.json", message: message)
    end
  end

  def sign_out(conn, _opts) do
    conn
        |> delete_session(:current_user_id)
        |> put_status(:ok)
        |> render(PhoenixApiWeb.ErrorView, "200.json", conn)
  end
end
