FactoryBot.define do
  factory :seller do
    name { "seller" }

    initialize_with { new(name) }
  end
end