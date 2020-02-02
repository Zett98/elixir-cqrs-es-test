defmodule BankApi.AccountLifespan do
  @behaviour Commanded.Aggregates.AggregateLifespan

  alias BankApi.Accounts.Events.{
    AccountClosed
  }

  alias BankApi.Accounts.Commands.{
    CloseAccount,
    DepositIntoAccount
  }

  def after_event(%DepositIntoAccount{}), do: :timer.hours(1)
  def after_event(%AccountClosed{}), do: :stop
  def after_event(_event), do: :infinity

  def after_command(%CloseAccount{}), do: :stop
  def after_command(_command), do: :infinity

  def after_error(_error), do: :stop
end
