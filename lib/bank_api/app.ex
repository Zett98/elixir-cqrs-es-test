defmodule BankApi.App do
  use Commanded.Application, otp_app: :bank_api

  router(BankApi.Router)
end
