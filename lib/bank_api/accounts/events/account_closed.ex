defmodule BankApi.Accounts.Events.AccountClosed do
  @derive Jason.Encoder

  defstruct [
    :account_uuid
  ]
end
