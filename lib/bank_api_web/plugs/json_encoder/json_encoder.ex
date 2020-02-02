defmodule BankApiWeb.Plugs.JSONEncoder do
  use ProperCase.JSONEncoder,
    transform: &ProperCase.to_camel_case/1,
    # optional, to use Jason instead of Poison
    json_encoder: Jason
end
