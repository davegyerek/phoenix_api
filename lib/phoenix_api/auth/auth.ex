defmodule PhoenixApi.Auth do
  @moduledoc """
  The Auth context.
  """

  import Ecto.Query, warn: false
  alias PhoenixApi.Repo

  alias PhoenixApi.Auth.User

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def authenticate_user(email, password) do
    query = from(u in User, where: u.email == ^email)
    query
    |> Repo.one()
    |> verify_password(password)
  end

  defp verify_password(nil, _) do
    Bcrypt.no_user_verify()
    {:error, "Wrong email or password"}
  end

  defp verify_password(user, password) do
    if Bcrypt.verify_pass(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "Wrong email or password"}
    end
  end
end
