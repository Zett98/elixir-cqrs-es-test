defmodule BankApi.Accounts.Projectors.AccountOpened do
  use Commanded.Projections.Ecto,
    application: BankApi.App,
    name: "Accounts.Projectors.AccountOpened",
    consistency: :strong

  alias BankApi.Accounts.Events.AccountOpened
  alias BankApi.Accounts.Projections.Account

  project(%AccountOpened{} = evt, _metadata, fn multi ->
    Ecto.Multi.insert(multi, :account_opened, %Account{
      uuid: evt.account_uuid,
      current_balance: evt.initial_balance,
      status: Account.status().open
    })
  end)
end
