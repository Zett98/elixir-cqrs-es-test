defmodule BankApi.Accounts.Commands.CloseAccount do
  @enforce_keys [:account_uuid]

  defstruct account_uuid: nil

  use Vex.Struct

  validates(:account_uuid, uuid: true)
end
