class UserParamsContract < Dry::Validation::Contract
  params do
    required(:name).value(:string)
    required(:email).value(:string)
    required(:password).value(:string)
  end
end
