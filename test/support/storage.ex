defmodule BankApi.Storage do
  def reset! do
    :ok = Application.stop(:bank_api)
    :ok = Application.stop(:commanded)

    reset_eventstore!()
    reset_readstore!()

    {:ok, _} = Application.ensure_all_started(:bank_api)
  end

  defp reset_eventstore! do
    {:ok, conn} =
      BankApi.EventStore.config()
      |> EventStore.Config.default_postgrex_opts()
      |> Postgrex.start_link()

    EventStore.Storage.Initializer.reset!(conn)
  end

  defp reset_readstore! do
    readstore_config = Application.get_env(:bank_api, Conduit.Repo)

    {:ok, conn} = Postgrex.start_link(readstore_config)

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      accounts,
      projection_versions
    RESTART IDENTITY
    CASCADE;
    """
  end
end
