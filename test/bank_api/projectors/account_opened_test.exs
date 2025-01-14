defmodule BankApi.Accounts.Projectors.AccountOpenedTest do
  use BankApi.ProjectorCase

  alias BankApi.Accounts.Projections.Account
  alias BankApi.Accounts.Events.AccountOpened
  alias BankApi.Accounts.Projectors.AccountOpened, as: Projector

  test "should succeed with valid data" do
    uuid = UUID.uuid4()

    account_opened_evt = %AccountOpened{
      account_uuid: uuid,
      initial_balance: 1_000
    }

    last_seen_event_number = get_last_seen_event_number("Accounts.Projectors.AccountOpened")

    assert :ok =
             Projector.handle(
               account_opened_evt,
               %{event_number: last_seen_event_number + 1}
             )

    assert only_instance_of(Account).current_balance == 1_000
    assert only_instance_of(Account).uuid == uuid
  end
end
