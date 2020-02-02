defmodule BankApiWeb.FallbackController do
  use BankApiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(BankApiWeb.ErrorView)
    |> render(:"404")
  end

  def call(conn, {:error, :account_already_closed}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankApiWeb.ErrorView)
    |> assign(:message, "Account already closed")
    |> render(:"422")
  end

  def call(conn, {:error, :account_closed}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankApiWeb.ErrorView)
    |> assign(:message, "Account closed")
    |> render(:"422")
  end

  def call(conn, {:error, :bad_command}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankApiWeb.ErrorView)
    |> render(:"422")
  end

  def call(conn, {:error, :validation_failure, errors}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankApiWeb.ValidationView)
    |> render("error.json", errors: errors)
  end

  def call(conn, {:error, :insufficient_funds}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankApiWeb.ErrorView)
    |> assign(:message, "Insufficient funds to process order")
    |> render(:"422")
  end

  def call(conn, {:error, :transfer_to_same_account}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(BankApiWeb.ErrorView)
    |> assign(:message, "Source and destination accounts are the same")
    |> render(:"422")
  end
end
