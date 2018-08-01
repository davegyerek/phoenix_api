defmodule PhoenixApiWeb.CompanyController do
  use PhoenixApiWeb, :controller

  alias PhoenixApi.Admin
  alias PhoenixApi.Admin.Company

  action_fallback PhoenixApiWeb.FallbackController

  def index(conn, _params) do
    companies = Admin.list_companies()
    render(conn, "index.json", companies: companies)
  end

  def create(conn, %{"company" => company_params}) do
    with {:ok, %Company{} = company} <- Admin.create_company(company_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", company_path(conn, :show, company))
      |> render("show.json", company: company)
    end
  end

  def show(conn, %{"id" => id}) do
    company = Admin.get_company!(id)
    render(conn, "show.json", company: company)
  end

  def update(conn, %{"id" => id, "company" => company_params}) do
    company = Admin.get_company!(id)

    with {:ok, %Company{} = company} <- Admin.update_company(company, company_params) do
      render(conn, "show.json", company: company)
    end
  end

  def delete(conn, %{"id" => id}) do
    company = Admin.get_company!(id)
    with {:ok, %Company{}} <- Admin.delete_company(company) do
      send_resp(conn, :no_content, "")
    end
  end
end
