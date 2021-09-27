FactoryBot.define do
  factory :cart do
    owner {}

    initialize_with { new(owner) }
  end
end
