defmodule PhoenixApiWeb.CompanyView do
  use PhoenixApiWeb, :view
  alias PhoenixApiWeb.CompanyView

  def render("index.json", %{companies: companies}) do
    %{data: render_many(companies, CompanyView, "company.json")}
  end

  def render("show.json", %{company: company}) do
    %{data: render_one(company, CompanyView, "company.json")}
  end

  def render("company.json", %{company: company}) do
    %{id: company.id,
      name: company.name,
      head_office: company.head_office,
      contact_name: company.contact_name,
      contact_phone: company.contact_phone,
      contact_email: company.contact_email,
      is_published: company.is_published}
  end
end
