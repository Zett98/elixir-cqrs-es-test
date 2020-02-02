defmodule BankApi.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      BankApi.App,
      BankApi.Repo,
      BankApiWeb.Endpoint,
      BankApi.Accounts.Supervisor
    ]

    opts = [strategy: :one_for_one, name: BankApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    BankApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
