defmodule BankApi.Router do
  use Commanded.Commands.Router

  alias BankApi.Accounts.Aggregates.Account

  alias BankApi.Accounts.Commands.{
    OpenAccount,
    CloseAccount,
    DepositIntoAccount,
    WithdrawFromAccount,
    TransferBetweenAccounts
  }

  middleware(BankApi.Middleware.ValidateCommand)

  dispatch(
    [OpenAccount, CloseAccount, DepositIntoAccount, WithdrawFromAccount, TransferBetweenAccounts],
    to: Account,
    lifespan: BankApi.AccountLifespan,
    identity: :account_uuid
  )
end
