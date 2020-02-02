defmodule BankApi.Accounts do
  @moduledoc """
  Accounts context
  """

  import Ecto.Query, warn: false

  alias BankApi.Repo

  alias BankApi.Accounts.Commands.{
    OpenAccount,
    CloseAccount,
    DepositIntoAccount,
    WithdrawFromAccount,
    TransferBetweenAccounts
  }

  alias BankApi.Accounts.Projections.Account
  alias BankApi.App

  def get_account(id) do
    case Repo.get(Account, Ecto.UUID.cast!(id)) do
      %Account{} = account ->
        {:ok, account}

      _reply ->
        {:error, :not_found}
    end
  end

  def close_account(id) do
    %CloseAccount{
      account_uuid: id
    }
    |> App.dispatch()
  end

  def open_account(%{"initial_balance" => initial_balance}) do
    account_uuid = UUID.uuid4(:default)

    dispatch_result =
      %OpenAccount{
        initial_balance: initial_balance,
        account_uuid: account_uuid
      }
      |> App.dispatch()

    case dispatch_result do
      :ok ->
        {
          :ok,
          %Account{
            uuid: account_uuid,
            current_balance: initial_balance,
            status: Account.status().open
          }
        }

      reply ->
        reply
    end
  end

  def open_account(_params), do: {:error, :bad_command}

  def deposit(id, amount) do
    dispatch_result =
      %DepositIntoAccount{
        account_uuid: id,
        deposit_amount: amount
      }
      |> App.dispatch(consistency: :strong)

    case dispatch_result do
      :ok ->
        {
          :ok,
          Repo.get!(Account, id)
        }

      reply ->
        reply
    end
  end

  def withdraw(id, amount) do
    dispatch_result =
      %WithdrawFromAccount{
        account_uuid: id,
        withdraw_amount: amount
      }
      |> App.dispatch(consistency: :strong)

    case dispatch_result do
      :ok ->
        {
          :ok,
          Repo.get!(Account, id)
        }

      reply ->
        reply
    end
  end

  @spec transfer(any, any, any) :: :ok | {:error, any}
  def transfer(source_id, amount, destination_id) do
    %TransferBetweenAccounts{
      account_uuid: source_id,
      transfer_uuid: UUID.uuid4(),
      transfer_amount: amount,
      destination_account_uuid: destination_id
    }
    |> App.dispatch()
  end
end
