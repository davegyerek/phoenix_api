defmodule PhoenixApi.AdminTest do
  use PhoenixApi.DataCase

  alias PhoenixApi.Admin

  describe "companies" do
    alias PhoenixApi.Admin.Company

    @valid_attrs %{contact_email: "some contact_email", contact_name: "some contact_name", contact_phone: "some contact_phone", head_office: "some head_office", is_published: true, name: "some name"}
    @update_attrs %{contact_email: "some updated contact_email", contact_name: "some updated contact_name", contact_phone: "some updated contact_phone", head_office: "some updated head_office", is_published: false, name: "some updated name"}
    @invalid_attrs %{contact_email: nil, contact_name: nil, contact_phone: nil, head_office: nil, is_published: nil, name: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Admin.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Admin.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Admin.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Admin.create_company(@valid_attrs)
      assert company.contact_email == "some contact_email"
      assert company.contact_name == "some contact_name"
      assert company.contact_phone == "some contact_phone"
      assert company.head_office == "some head_office"
      assert company.is_published == true
      assert company.name == "some name"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admin.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, company} = Admin.update_company(company, @update_attrs)
      assert %Company{} = company
      assert company.contact_email == "some updated contact_email"
      assert company.contact_name == "some updated contact_name"
      assert company.contact_phone == "some updated contact_phone"
      assert company.head_office == "some updated head_office"
      assert company.is_published == false
      assert company.name == "some updated name"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Admin.update_company(company, @invalid_attrs)
      assert company == Admin.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Admin.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Admin.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Admin.change_company(company)
    end
  end
end
