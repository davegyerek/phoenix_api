defmodule PhoenixApiWeb.SessionView do
  use PhoenixApiWeb, :view


  def render("sign_in.json", %{user: user}) do
    %{
      data: %{
        user: %{
          id: user.id,
          email: user.email,
        }
      }
    }
  end
end
