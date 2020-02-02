defmodule BankApi.Support.Validators.PositiveInteger do
  use Vex.Validator

  def validate(value, _options) do
    positive_integer?(value)
  end

  defp positive_integer?(data) do
    cond do
      is_integer(data) ->
        if data > 0 do
          :ok
        else
          {:error, "Argument must be bigger than zero"}
        end

      true ->
        {:error, "Argument must be an integer"}
    end
  end
end
