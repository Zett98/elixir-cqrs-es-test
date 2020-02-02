defmodule BankApi.Accounts.Projectors.DepositsAndWithdrawals do
  use Commanded.Projections.Ecto,
    name: "Accounts.Projectors.DepositsAndWithdrawals",
    application: BankApi.App,
    consistency: :strong

  alias BankApi.Accounts
  alias BankApi.Accounts.Events.{DepositedIntoAccount, WithdrawnFromAccount}
  alias BankApi.Accounts.Projections.Account
  alias Ecto.{Changeset, Multi}

  project(%DepositedIntoAccount{} = evt, _metadata, fn multi ->
    with {:ok, %Account{} = account} <- Accounts.get_account(evt.account_uuid) do
      Multi.update(
        multi,
        :account,
        Changeset.change(
          account,
          current_balance: evt.new_current_balance
        )
      )
    else
      # ignore when this happens
      _ -> multi
    end
  end)

  project(%WithdrawnFromAccount{} = evt, _metadata, fn multi ->
    with {:ok, %Account{} = account} <- Accounts.get_account(evt.account_uuid) do
      Multi.update(
        multi,
        :account,
        Changeset.change(
          account,
          current_balance: evt.new_current_balance
        )
      )
    else
      # ignore when this happens
      _ -> multi
    end
  end)
end
