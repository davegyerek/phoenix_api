defmodule PhoenixApi.Admin.Company do
  use Ecto.Schema
  import Ecto.Changeset


  schema "companies" do
    field :contact_email, :string
    field :contact_name, :string
    field :contact_phone, :string
    field :head_office, :string
    field :is_published, :boolean, default: false
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :head_office, :contact_name, :contact_phone, :contact_email, :is_published])
    |> validate_required([:name])
  end
end
