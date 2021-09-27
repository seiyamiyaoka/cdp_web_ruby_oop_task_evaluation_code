FactoryBot.define do
  factory :customer do
    name { "customer" }

    initialize_with { new(name) }
  end
end
