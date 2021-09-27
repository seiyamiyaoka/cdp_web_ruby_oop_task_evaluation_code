FactoryBot.define do
  factory :user do
    name { "user" }

    initialize_with { new(name) }
  end
end