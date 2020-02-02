defmodule BankApiWeb.ValidationView do
  use BankApiWeb, :view

  def render("error.json", %{errors: errors}) do
    %{errors: errors}
  end
end
