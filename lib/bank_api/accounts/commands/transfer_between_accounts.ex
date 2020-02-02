defmodule BankApi.Accounts.Commands.TransferBetweenAccounts do
  @enforce_keys [:account_uuid, :transfer_uuid]

  defstruct [:account_uuid, :transfer_uuid, :transfer_amount, :destination_account_uuid]

  use Vex.Struct

  validates(:account_uuid, uuid: true)
  validates(:transfer_uuid, uuid: true)

  validates(:destination_account_uuid,
    uuid: true,
    by: &BankApi.Support.Validators.ViableAccount.validate/2
  )

  validates(:transfer_amount,
    number: [is: true, allow_nil: false, allow_blank: false],
    by: &BankApi.Support.Validators.PositiveInteger.validate/2
  )
end
