defmodule BankApi.Accounts.Commands.DepositIntoAccount do
  @enforce_keys [:account_uuid]

  defstruct account_uuid: nil, deposit_amount: nil, transfer_uuid: nil

  use Vex.Struct

  validates(:account_uuid, uuid: true)
  validates(:transfer_uuid, uuid: true)

  validates(:deposit_amount,
    number: [is: true, allow_nil: false, allow_blank: false],
    by: &BankApi.Support.Validators.PositiveInteger.validate/2
  )
end
