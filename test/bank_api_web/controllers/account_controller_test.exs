defmodule BankApiWeb.AccountControllerTest do
  use BankApiWeb.ConnCase

  @create_attrs %{
    initialBalance: 42_00
  }
  @invalid_attrs %{
    initial_balsnce: nil
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.account_path(conn, :create),
          account: @create_attrs
        )

      assert %{
               "uuid" => _uuid,
               "currentBalance" => 4200
             } = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(
          conn,
          Routes.account_path(conn, :create),
          account: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
