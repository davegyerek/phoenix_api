defmodule PhoenixApiWeb.Router do
  use PhoenixApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/api", PhoenixApiWeb do
    pipe_through :api

    post "/users/sign_in", SessionController, :sign_in
    post "/users/sign_out", SessionController, :sign_out
  end

  scope "/api", PhoenixApiWeb do
    pipe_through [:api, :api_auth]

    resources "/users", UserController, except: [:new, :edit]
    resources "/companies", CompanyController, except: [:new, :edit]
  end

  defp ensure_authenticated(conn, _opts) do
    current_user_id = get_session(conn, :current_user_id)

    if current_user_id do
      conn
    else
      conn
      |> put_status(:unauthorized)
      |> render(PhoenixApiWeb.ErrorView, "401.json", message: "Unauthenticated user")
      |> halt()
    end
  end
end
