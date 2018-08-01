defmodule PhoenixApi.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string, null: false
      add :head_office, :string
      add :contact_name, :string
      add :contact_phone, :string
      add :contact_email, :string
      add :is_published, :boolean, default: false, null: false

      timestamps()
    end
  end
end
