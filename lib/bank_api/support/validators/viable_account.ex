defmodule BankApi.Support.Validators.ViableAccount do
  use Vex.Validator
  alias BankApi.Accounts.Projections.Account
  alias BankApi.Repo

  def validate(value, _option) do
    with %Account{} <- account_exists?(value),
         true <- account_open?(value) do
      :ok
    else
      nil ->
        {:error, ["Destination account does not exist"]}

      false ->
        {:error, ["Destination account closed"]}

      reply ->
        reply
    end
  end

  defp account_exists?(uuid) do
    Repo.get(Account, uuid)
  end

  defp account_open?(uuid) do
    account = Repo.get!(Account, uuid)
    account.status == Account.status().open
  end
end
