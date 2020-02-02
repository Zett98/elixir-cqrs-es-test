defmodule BankApi.ProjectorCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      alias BankApi.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import BankApi.DataCase

      import BankApi.Test.ProjectorUtils
    end
  end

  setup _tags do
    :ok = BankApi.Test.ProjectorUtils.truncate_database()

    :ok
  end
end
