defmodule BankApi.Accounts.Projectors.AccountClosed do
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.AccountClosed",
    application: BankApi.App

  alias BankApi.Accounts
  alias BankApi.Accounts.Events.AccountClosed
  alias BankApi.Accounts.Projections.Account
  alias Ecto.{Changeset, Multi}

  project(%AccountClosed{} = evt, _metadata, fn multi ->
    with {:ok, %Account{} = account} <- Accounts.get_account(evt.account_uuid) do
      Multi.update(
        multi,
        :account,
        Changeset.change(account, status: Account.status().closed)
      )
    else
      # ignore when this happens
      _ -> multi
    end
  end)
end
