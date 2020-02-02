defmodule BankApiWeb.Router do
  use BankApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug ProperCase.Plug.SnakeCaseParams
  end

  scope "/api", BankApiWeb do
    pipe_through :api

    resources "/accounts", AccountController, only: [:create, :delete, :show]
    post "/accounts/:id/deposit", AccountController, :deposit
    post "/accounts/:id/withdraw", AccountController, :withdraw
    post "/accounts/:id/transfer", AccountController, :transfer
  end
end
