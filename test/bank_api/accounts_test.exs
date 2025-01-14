defmodule BankApi.Accounts.AccountsTest do
  use BankApi.Test.EventStoreCase

  alias BankApi.Accounts
  alias BankApi.Accounts.Projections.Account

  test "opens account with valid command" do
    params = %{
      "initial_balance" => 1_000
    }

    assert {:ok, %Account{current_balance: 1_000}} = Accounts.open_account(params)
  end

  test "does not dispatch command with invalid payload" do
    params = %{
      "initial_whatevs" => 1_000
    }

    assert {:error, :bad_command} = Accounts.open_account(params)
  end

  test "returns validation errors from dispatch" do
    params1 = %{
      "initial_balance" => "1_000"
    }

    params2 = %{
      "initial_balance" => -10
    }

    params3 = %{
      "initial_balance" => 0
    }

    assert {
             :error,
             :validation_failure,
             %{initial_balance: ["must be a number", "Argument must be an integer"]}
           } = Accounts.open_account(params1)

    assert {
             :error,
             :validation_failure,
             %{initial_balance: ["Argument must be bigger than zero"]}
           } = Accounts.open_account(params2)

    assert {
             :error,
             :validation_failure,
             %{initial_balance: ["Argument must be bigger than zero"]}
           } = Accounts.open_account(params3)
  end
end
