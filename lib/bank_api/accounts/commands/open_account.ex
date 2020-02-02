defmodule BankApi.Accounts.Commands.OpenAccount do
  defstruct account_uuid: nil, initial_balance: nil

  use Vex.Struct

  validates(:account_uuid, uuid: true)

  validates(:initial_balance,
    number: [is: true, allow_nil: false, allow_blank: false],
    by: &BankApi.Support.Validators.PositiveInteger.validate/2
  )
end
